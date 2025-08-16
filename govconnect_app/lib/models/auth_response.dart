import 'package:govconnect_app/models/user.dart';

class AuthResponse {
  final String accessToken;
  final int statusCode;
  final User user;

  AuthResponse({
    required this.accessToken,
    required this.statusCode,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['token'],
      statusCode: json['statusCode'],
      user: User.fromJson(json['user']),
    );
  }
}
