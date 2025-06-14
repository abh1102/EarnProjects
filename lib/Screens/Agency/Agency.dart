import 'package:earnprojects/Screens/Agency/AgencyCards.dart';
import 'package:flutter/material.dart';

import '../../Model/Agency.dart';
import '../../Model/AllPlansModel.dart';
// screens/agency_screen.dart

class AgencyScreen extends StatelessWidget {
  const AgencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plans = AgencyPlans.getPlans(context);

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
                    child: AgencyCards(plan: plan),
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