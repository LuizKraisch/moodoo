import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;
import 'package:moodoo/config.dart';
import 'package:moodoo/models/song.dart';
import 'package:moodoo/preferences/spotify_preferences.dart';
import 'package:moodoo/services/api_service.dart';
import 'package:moodoo/services/auth_service.dart';

class SpotifyService {
  static final SpotifyService _instance = SpotifyService._internal();
  factory SpotifyService() => _instance;
  SpotifyService._internal();

  static const String _baseUrl = apiBaseUrl;
  static const String callbackScheme = 'moodoo';

  Future<Map<String, String>> _authHeaders() async {
    final token = await AuthService().getToken();
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  Future<bool> connect() async {
    final headers = await _authHeaders();
    final authorizeResponse = await http.post(
      Uri.parse('$_baseUrl/spotify/authorize'),
      headers: headers,
    );
    handleApiResponse(authorizeResponse);
    final authorize = jsonDecode(authorizeResponse.body) as Map<String, dynamic>;

    final String result;
    try {
      result = await FlutterWebAuth2.authenticate(
        url: authorize['url'] as String,
        callbackUrlScheme: callbackScheme,
      );
    } on PlatformException catch (e) {
      if (e.code == 'CANCELED') return false;
      rethrow;
    }

    final params = Uri.parse(result).queryParameters;
    final code = params['code'];
    if (code == null) return false;

    final connectResponse = await http.post(
      Uri.parse('$_baseUrl/spotify/connect'),
      headers: headers,
      body: jsonEncode({'code': code, 'state': params['state']}),
    );
    handleApiResponse(connectResponse);
    final data = jsonDecode(connectResponse.body) as Map<String, dynamic>;
    await saveSpotifyConnection(
      connected: data['spotify_connected'] as bool? ?? true,
      displayName: data['spotify_display_name'] as String?,
    );
    return true;
  }

  Future<void> disconnect() async {
    final headers = await _authHeaders();
    final response = await http.delete(
      Uri.parse('$_baseUrl/spotify/connection'),
      headers: headers,
    );
    handleApiResponse(response, expected: 204);
    await saveSpotifyConnection(connected: false);
  }

  Future<List<Song>> topTracks() => _getSongs('$_baseUrl/spotify/top_tracks');

  Future<List<Song>> search(String query) => _getSongs(
    '$_baseUrl/spotify/search?q=${Uri.encodeQueryComponent(query)}',
  );

  Future<List<Song>> _getSongs(String url) async {
    final headers = await _authHeaders();
    final response = await http.get(Uri.parse(url), headers: headers);
    handleApiResponse(response);
    final List<dynamic> data = jsonDecode(response.body);
    return data
        .map((s) => Song.fromJson(s as Map<String, dynamic>))
        .toList();
  }
}
