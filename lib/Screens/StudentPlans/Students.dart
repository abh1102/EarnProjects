import 'package:flutter/material.dart';

import '../../Model/AllPlansModel.dart';
import '../../Model/StudentPlansModel.dart';
import 'StudentCardsPlan.dart';
// screens/student_screen.dart

class StudentScreen extends StatelessWidget {
  const StudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plans = StudentPlans.getPlans(context);

    return Scaffold(

      body: LayoutBuilder(
        builder: (context, constraints) {
          double cardWidth = constraints.maxWidth > 600
              ? (constraints.maxWidth - 36) / 2
              : constraints.maxWidth;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: plans.map((plan) {
                return SizedBox(
                  width: cardWidth,
                  child: GestureDetector(
                    onTap: plan.onTap,
                    child: StudentCardsPlan(plan: plan),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}