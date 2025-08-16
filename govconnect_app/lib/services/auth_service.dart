import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "http://10.0.2.2:8080/api"));

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      response.data['statusCode'] = response.statusCode;
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? e.message);
    }
  }

  Future<Map<String, dynamic>> register(
    String nic,
    String email,
    String password,
  ) async {
    try {
      final response = await _dio.post(
        '/auth/register/user',
        data: {
          "firstname": "null",
          "lastname": "null",
          "contact": "0807654532",
          "email": email,
          "password": password,
          "address": {
            "city": "null",
            "town": "null",
            "province": "null",
            "streetAddress": "null"
          },
          "dob": "1995-08-14",
          "gender": "MALE",
          "nic": nic
        },
      );

      print("Register success: ${response.statusCode}");
      response.data['statusCode'] = response.statusCode;
      return response.data;
    } on DioException catch (e) {
      print("Register failed: ${e.response?.data ?? e.message}");
      rethrow;
    }
  }
}
