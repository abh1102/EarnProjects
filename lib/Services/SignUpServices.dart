import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../Config/Config.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConfig.baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ));

  Future<Response> signUp({
    required String email,
    required String password,
    required String confirmPassword,
    required String name,
    required String category,
    required String mobile,
  }) async {
    try {
      final response = await _dio.post(
        ApiConfig.signUpEndpoint,
        data: {
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
          "name": name,
          "category": category,
          "mobile": mobile,
        },
      );
      return response;
    } on DioException catch (e) {
      if (kDebugMode) {
        print('Dio error: $e');
      }
      rethrow;
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      rethrow;
    }
  }

  Future<Response> verifyEmail({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _dio.post(
        ApiConfig.verifyEmailEndpoint,
        data: {
          "email": email,
          "otp": otp,
        },
      );
      return response;
    } on DioException catch (e) {
      if (kDebugMode) {
        print('Dio error: $e');
      }
      rethrow;
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      rethrow;
    }
  }
}