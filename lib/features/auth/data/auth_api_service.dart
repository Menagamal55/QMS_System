import 'package:dio/dio.dart';

class AuthApiService {
  final Dio _dio = Dio();
  final String baseUrl = "http://qms-api.runasp.net/api/User";

  Future<Response> login(String email, String password) async {
    return await _dio.post("$baseUrl/login", data: {
      "email": email,
      "password": password,
    });
  }

  Future<Response> register(Map<String, dynamic> userData) async {
    return await _dio.post("$baseUrl/register", data: userData);
  }
}