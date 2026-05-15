import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;

class UserInfo {
  final String id;
  final String email;
  final String name;
  final String? photoUrl;

  const UserInfo({
    required this.id,
    required this.email,
    required this.name,
    this.photoUrl,
  });
}

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  static const String _baseUrl = 'http://localhost:3000';
  static const _storage = FlutterSecureStorage();

  UserInfo? _currentUser;
  final _authStateController = StreamController<bool>.broadcast();
  final List<void Function()> _signOutListeners = [];

  void addSignOutListener(void Function() listener) {
    _signOutListeners.add(listener);
  }

  UserInfo? getCurrentUser() => _currentUser;
  String? get userEmail => _currentUser?.email;
  String? get userName {
    final name = _currentUser?.name;
    return (name != null && name.isNotEmpty) ? name : null;
  }
  String? get userPhotoUrl => _currentUser?.photoUrl;

  Future<String?> getToken() => _storage.read(key: 'jwt_token');

  Stream<bool> authStateChanges() {
    final controller = StreamController<bool>();

    Future<void> init() async {
      final token = await _storage.read(key: 'jwt_token');
      if (token != null) await _loadCachedUser();
      if (!controller.isClosed) controller.add(token != null);

      final sub = _authStateController.stream.listen(
        (value) { if (!controller.isClosed) controller.add(value); },
        onDone: () { if (!controller.isClosed) controller.close(); },
      );
      controller.onCancel = () => sub.cancel();
    }

    init();
    return controller.stream;
  }

  Future<void> _loadCachedUser() async {
    final id = await _storage.read(key: 'user_id');
    final email = await _storage.read(key: 'user_email');
    final name = await _storage.read(key: 'user_name');
    final photoUrl = await _storage.read(key: 'user_photo_url');
    if (id != null && email != null) {
      _currentUser = UserInfo(id: id, email: email, name: name ?? '', photoUrl: photoUrl);
    }
  }

  Future<void> _handleAuthResponse(http.Response response) async {
    if (response.statusCode != 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception(body['error'] ?? 'Authentication failed');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final token = data['token'] as String;
    final user = data['user'] as Map<String, dynamic>;
    final photoUrl = user['photo_url'] as String?;

    _currentUser = UserInfo(
      id: user['id'] as String,
      email: user['email'] as String,
      name: user['name'] as String? ?? '',
      photoUrl: photoUrl,
    );

    await _storage.write(key: 'jwt_token', value: token);
    await _storage.write(key: 'user_id', value: _currentUser!.id);
    await _storage.write(key: 'user_email', value: _currentUser!.email);
    await _storage.write(key: 'user_name', value: _currentUser!.name);
    if (photoUrl != null) {
      await _storage.write(key: 'user_photo_url', value: photoUrl);
    } else {
      await _storage.delete(key: 'user_photo_url');
    }

    _authStateController.add(true);
  }

  Future<void> signInWithGoogle() async {
    final googleUser = await GoogleSignIn.instance.authenticate();
    final idToken = googleUser.authentication.idToken;
    if (idToken == null) throw Exception('Failed to get Google ID token');

    final response = await http.post(
      Uri.parse('$_baseUrl/auth/google'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id_token': idToken}),
    );

    await _handleAuthResponse(response);
  }

  Future<void> signInWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final idToken = credential.identityToken;
    if (idToken == null) throw Exception('Failed to get Apple ID token');

    final nameParts = [credential.givenName, credential.familyName]
        .whereType<String>()
        .where((s) => s.isNotEmpty)
        .toList();

    final body = <String, String>{'id_token': idToken};
    if (nameParts.isNotEmpty) body['name'] = nameParts.join(' ');
    if (credential.email != null) body['email'] = credential.email!;

    final response = await http.post(
      Uri.parse('$_baseUrl/auth/apple'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    await _handleAuthResponse(response);
  }

  Future<void> signOut() async {
    for (final listener in _signOutListeners) {
      listener();
    }
    try {
      await GoogleSignIn.instance.signOut();
    } catch (_) {}
    await _storage.deleteAll();
    _currentUser = null;
    _authStateController.add(false);
  }
}
