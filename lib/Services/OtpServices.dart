import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

class OtpService {
  static const String _baseUrl = 'https://earnprojects-backend.onrender.com/api/auth';
  static final Dio _dio = Dio();

  static Future<String?> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    print('[OtpService] Retrieved token: $token'); // DEBUG

    return token;
  }

  static Future<Response> sendOtp(String email) async {
    print('[OtpService] Sending OTP to: $email');
    final token = await _getAuthToken();
    if (token == null) log('[OtpService] Warning: No token found');

    try {
      final response = await _dio.post(
        '$_baseUrl/send-otp',
        data: {'email': email},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            // 'Authorization': 'Bearer $token', // Uncomment if needed
          },
        ),
      );
      log('[OtpService] OTP Send Response: ${response.statusCode} - ${response.data}');
      return response;
    } catch (e) {
      log('[OtpService] Error sending OTP: $e');
      rethrow;
    }
  }

  static Future<Response> verifyOtp(String email, String otp) async {
    print('[OtpService] Verifying OTP: $otp for $email');

    try {
      final response = await _dio.post(
        '$_baseUrl/verify-otp',
        data: {'email': email, 'otp': otp},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      // 📦 Detailed logging
      print('[OtpService] --- VERIFY OTP RESPONSE ---');
      print('Status Code: ${response.statusCode}');
      print('Headers: ${response.headers}');
      print('Body: ${response.data}');
      print('[OtpService] --------------------------------');

      // ✅ Save token if present
      if (response.statusCode == 200 && response.data['token'] != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', response.data['token']);
        print('[OtpService] Saved token: ${response.data['token']}');
      }

      return response;
    } catch (e) {
      print('[OtpService] Error verifying OTP: $e');
      rethrow;
    }
  }
}
