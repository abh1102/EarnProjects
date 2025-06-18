import 'package:earnprojects/Screens/StudentPlans/forms_after_choosingPlans_students.dart';
import 'package:flutter/material.dart';

import '../Services/PlanServices.dart';
import 'AllPlansModel.dart';
// models/student_plans_model.dart
class StudentPlans {
  static Future<List<Plan>> fetchPlans(BuildContext context) async {
    final jsonList = await PlanService.fetchPlans(category: 'student');

    return jsonList.map((json) {
      return Plan.fromJson(json, () {
        _navigateToCheckout(context, json);
      });
    }).toList();
  }

  static void _navigateToCheckout(BuildContext context, Map<String, dynamic> planJson) {
    final plan = Plan.fromJson(planJson, () {});
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentsCheckoutScreen(plan: plan),
      ),
    );
  }
}