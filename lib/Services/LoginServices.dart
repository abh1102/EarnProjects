import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  static const String _baseUrl = 'https://earnprojects-backend.onrender.com/api';

  static Future<Response> login(String email, String password) async {
    try {
      final Dio dio = Dio();

      final response = await dio.post(
        '$_baseUrl/auth/login',
        data: {
          'email': email,
          'password': password,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      // ✅ Save token
      if (response.statusCode == 200 && response.data['token'] != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.data['token']);
      }

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
