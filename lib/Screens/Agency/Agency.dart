import 'package:earnprojects/Screens/Agency/AgencyCards.dart';
import 'package:flutter/material.dart';

import '../../Model/Agency.dart';
import '../../Model/AllPlansModel.dart';
// screens/agency_screen.dart

class AgencyScreen extends StatefulWidget {
  const AgencyScreen({super.key});

  @override
  State<AgencyScreen> createState() => _AgencyScreenState();
}

class _AgencyScreenState extends State<AgencyScreen> {
  late Future<List<Plan>> _plansFuture;

  @override
  void initState() {
    super.initState();
    _plansFuture = AgencyPlans.fetchPlans(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agency Plans")),
      body: FutureBuilder<List<Plan>>(
        future: _plansFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error loading plans: ${snapshot.error}"));
          }

          final plans = snapshot.data!;
          return LayoutBuilder(
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
                      child: AgencyCards(plan: plan),
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
