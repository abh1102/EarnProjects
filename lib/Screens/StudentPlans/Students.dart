import 'package:flutter/material.dart';

import '../../Model/AllPlansModel.dart';
import '../../Model/StudentPlansModel.dart';
import 'StudentCardsPlan.dart';
// screens/student_screen.dart

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  late Future<List<Plan>> _plansFuture;

  @override
  void initState() {
    super.initState();
    _plansFuture = StudentPlans.fetchPlans(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student Plans")),
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
                      child: StudentCardsPlan(plan: plan),
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
