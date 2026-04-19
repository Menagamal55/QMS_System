
import 'package:dio/dio.dart'; 
import 'package:sw2project/core/base_usecase/Api%20constants.dart';
import 'package:sw2project/core/base_usecase/Exceptions%20.dart';
import 'package:sw2project/features/auth/data/User%20model%20.dart';
import '../../../../core/network/dio_client.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  const AuthRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dioClient.post(
        ApiConstants.loginEndpoint,
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        if (data is Map<String, dynamic>) {
          return UserModel.fromJson(data);
        }
        throw const ServerException(message: 'Invalid response format');
      }

      throw ServerException(
        message: 'Login failed',
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      
      String errorMessage = "حدث خطأ غير معروف";
      if (e.response != null && e.response?.data != null) {
        
        print("====== SERVER ERROR (LOGIN) ======");
        print(e.response?.data); 
        print("==================================");
        errorMessage = e.response?.data.toString() ?? e.message.toString();
      }
      throw ServerException(message: errorMessage);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await dioClient.post(
        ApiConstants.registerEndpoint,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'Role': 'User',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        if (data is Map<String, dynamic>) {
          return UserModel.fromJson(data);
        }
        throw const ServerException(message: 'Invalid response format');
      }

      throw ServerException(
        message: 'Registration failed',
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      // هنا بنقرا الإيرور الحقيقي بتاع الـ Register
      String errorMessage = "حدث خطأ غير معروف";
      if (e.response != null && e.response?.data != null) {
        print("====== SERVER ERROR (REGISTER) ======");
        print(e.response?.data); // السطر ده هيفضح المشكلة!
        print("=====================================");
        errorMessage = e.response?.data.toString() ?? e.message.toString();
      }
      throw ServerException(message: errorMessage);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}