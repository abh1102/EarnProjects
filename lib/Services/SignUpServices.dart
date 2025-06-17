import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../Config/Config.dart';

import 'package:dio/dio.dart';

// services/auth_service.dart

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<Response> completeSignup({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      final response = await Dio().post(
        "https://earnprojects-backend.onrender.com/api/auth/complete-signup",
        data: {
          "name": name,
          "mobile": phone,
          "email": email,
          "password": password,
          "role": role
        },
      );

      if (response.statusCode == 200 && response.data["token"] != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", response.data["token"]);
      }

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
