// models/professional_plans_model.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Screens/Professionals/Forms_After_Choosing_Plans.dart';
import '../Services/PlanServices.dart';
import 'AllPlansModel.dart';

import 'package:flutter/material.dart';


class ProfessionalPlans {
  static Future<List<Plan>> fetchPlans(BuildContext context) async {
    final jsonList = await PlanService.fetchPlans(category: 'professional');

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
        builder: (context) => ProfessionCheckoutScreen(plan: plan),
      ),
    );
  }
}
