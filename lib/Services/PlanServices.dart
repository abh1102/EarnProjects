// services/plan_service.dart
import 'package:dio/dio.dart';
import 'package:earnprojects/Config/Config.dart';

class PlanService {
  static Future<List<Map<String, dynamic>>> fetchPlans({String category = "all"}) async {
    try {
      final response = await Dio().post(
        ApiConfig.plans,
        data: {"category": category},
      );

      if (response.statusCode == 200 && response.data["plans"] != null) {
        return List<Map<String, dynamic>>.from(response.data["plans"]);
      } else {
        throw Exception('Failed to load plans');
      }
    } catch (e) {
      rethrow;
    }
  }
}
