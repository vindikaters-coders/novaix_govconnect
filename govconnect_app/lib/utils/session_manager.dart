import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import '../models/auth_response.dart';
import '../models/user.dart';

class SessionManager {
  final _storage = const FlutterSecureStorage();

  Future<void> saveSession(AuthResponse auth) async {
    await _storage.write(key: 'accessToken', value: auth.accessToken);
    await _storage.write(key: 'user', value: jsonEncode({
      'id': auth.user.id,
      'email': auth.user.email,
      'firstname': auth.user.firstname,
      'role': auth.user.role,
    }));
  }

  Future<User?> getUser() async {
    final data = await _storage.read(key: 'user');
    if (data == null) return null;
    return User.fromJson(jsonDecode(data));
  }

  Future<void> clearSession() async {
    await _storage.deleteAll();
  }
}
