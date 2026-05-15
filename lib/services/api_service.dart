import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:moodoo/models/mood.dart';
import 'package:moodoo/services/auth_service.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal() {
    AuthService().addSignOutListener(reset);
  }

  static const String _baseUrl = 'http://localhost:3000';
  static const String _wsUrl = 'ws://localhost:3000/cable';
  static const String _cableIdentifier = '{"channel":"MoodsChannel"}';

  final _moodsController = StreamController<List<Mood>>.broadcast();
  List<Mood> _moods = [];
  WebSocketChannel? _channel;
  bool _initialized = false;

  Stream<List<Mood>> getMoods() {
    if (!_initialized) {
      _initialized = true;
      _loadMoods();
      _connectWebSocket();
    }
    return _moodsController.stream;
  }

  Stream<List<Mood>> getMoodsForMonth(int month, int year) {
    return getMoods().map(
      (moods) =>
          moods.where((m) => m.day.month == month && m.day.year == year).toList(),
    );
  }

  Future<Map<String, String>> _authHeaders() async {
    final token = await AuthService().getToken();
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  Future<void> _loadMoods() async {
    try {
      final headers = await _authHeaders();
      final response = await http.get(
        Uri.parse('$_baseUrl/moods'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _moods = data.map((m) => Mood.fromJson(m as Map<String, dynamic>)).toList();
        _moodsController.add(List.from(_moods));
      } else if (response.statusCode == 401) {
        await AuthService().signOut();
      } else {
        _moodsController.add([]);
      }
    } catch (_) {
      _moodsController.add([]);
    }
  }

  Future<void> _connectWebSocket() async {
    try {
      final token = await AuthService().getToken();
      if (token == null) return;

      _channel = WebSocketChannel.connect(
        Uri.parse('$_wsUrl?token=${Uri.encodeComponent(token)}'),
      );

      await _channel!.ready;

      _channel!.sink.add(jsonEncode({
        'command': 'subscribe',
        'identifier': _cableIdentifier,
      }));

      _channel!.stream.listen(
        (data) {
          final message = jsonDecode(data as String) as Map<String, dynamic>;

          // Skip control messages: welcome, ping, confirm_subscription, disconnect
          if (message.containsKey('type')) return;

          final msg = message['message'] as Map<String, dynamic>?;
          if (msg == null) return;

          final action = msg['action'] as String?;
          final moodData = msg['mood'] as Map<String, dynamic>?;
          if (action == null || moodData == null) return;

          final mood = Mood.fromJson(moodData);

          switch (action) {
            case 'created':
              _moods.add(mood);
            case 'updated':
              final idx = _moods.indexWhere((m) => m.id == mood.id);
              if (idx != -1) _moods[idx] = mood;
            case 'deleted':
              _moods.removeWhere((m) => m.id == mood.id);
          }

          _moodsController.add(List.from(_moods));
        },
        onError: (_) => _scheduleReconnect(),
        onDone: () => _scheduleReconnect(),
      );
    } catch (_) {
      _scheduleReconnect();
    }
  }

  void _scheduleReconnect() {
    Future.delayed(const Duration(seconds: 4), () {
      if (_initialized) _connectWebSocket();
    });
  }

  Future<void> addMood(DateTime day, String score, String notes) async {
    final headers = await _authHeaders();
    final response = await http.post(
      Uri.parse('$_baseUrl/moods'),
      headers: headers,
      body: jsonEncode({
        'mood': {
          'day': _formatDate(day),
          'score': score,
          'notes': notes,
        },
      }),
    );
    _handleResponse(response, expected: 201);
  }

  Future<void> updateMood(String id, String notes, String score) async {
    final headers = await _authHeaders();
    final response = await http.patch(
      Uri.parse('$_baseUrl/moods/$id'),
      headers: headers,
      body: jsonEncode({
        'mood': {
          'notes': notes,
          'score': score,
        },
      }),
    );
    _handleResponse(response);
  }

  Future<void> deleteMood(String id) async {
    final headers = await _authHeaders();
    final response = await http.delete(
      Uri.parse('$_baseUrl/moods/$id'),
      headers: headers,
    );
    if (response.statusCode != 204) _handleResponse(response);
  }

  Future<void> deleteAllMoods() async {
    final headers = await _authHeaders();
    final response = await http.get(
      Uri.parse('$_baseUrl/moods'),
      headers: headers,
    );
    if (response.statusCode != 200) {
      _handleResponse(response);
      return;
    }
    final List<dynamic> data = jsonDecode(response.body);
    final ids = data.map((m) => (m as Map<String, dynamic>)['id'] as String).toList();
    for (final id in ids) {
      await deleteMood(id);
    }
  }

  void _handleResponse(http.Response response, {int expected = 200}) {
    if (response.statusCode == expected) return;
    try {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      if (body.containsKey('errors')) {
        final errors = (body['errors'] as List).join(', ');
        throw ApiException(errors, statusCode: response.statusCode);
      }
      if (body.containsKey('error')) {
        throw ApiException(body['error'] as String, statusCode: response.statusCode);
      }
    } on ApiException {
      rethrow;
    } catch (_) {}
    throw ApiException('Request failed', statusCode: response.statusCode);
  }

  String _formatDate(DateTime date) {
    final y = date.year;
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  void reset() {
    _channel?.sink.close();
    _channel = null;
    _moods = [];
    _initialized = false;
  }
}
