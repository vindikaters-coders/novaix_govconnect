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
    String password, String lastName, String firstName, String city, String dob, String phone,
      String gender
  ) async {

    print("data ${gender}");
    try {
      final response = await _dio.post(
        '/auth/register/user',
        data: {
          "firstname": firstName,
          "lastname": lastName,
          "contact": phone,
          "email": email,
          "password": password,
          "address": {
            "city": city,
            "town": 'null',
            "province": 'null',
            "streetAddress": 'null'
          },
          "dob": dob,
          "gender": gender,
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
