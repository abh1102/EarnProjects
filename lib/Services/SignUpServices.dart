import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../Config/Config.dart';

import 'package:dio/dio.dart';

// services/auth_service.dart

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<Response> completeSignup({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String role,
    required String confirmPassword,
    String countryCode = 'IN', // Default to 'IN'
  }) async {
    print('[AuthService] Signup requested with:');
    print('  Name: $name');
    print('  Phone: $phone');
    print('  Email: $email');
    print('  Role: $role');
    print('  Password: $password');
    print('  ConfirmPassword: $confirmPassword');
    print('  CountryCode: $countryCode');

    try {
      final response = await Dio().post(
        ApiConfig.signUpEndpoint,
        // "https://earnprojects-backend.onrender.com/api/auth/complete-signup",
        data: {
          "name": name,
          "mobile": phone,
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
          "category": role,
          "country_code": countryCode,
        },
      );

      print('[AuthService] Response status: ${response.statusCode}');
      print('[AuthService] Response data: ${response.data}');

      if (response.statusCode == 200 && response.data["token"] != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", response.data["token"]);
        print('[AuthService] Token saved.');
      }

      return response;
    } catch (e) {
      print('[AuthService] Error: $e');
      rethrow;
    }
  }
}
