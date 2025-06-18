import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../../Model/AllPlansModel.dart';
import '../../Services/PlanServices.dart';
import 'AllPlansCards.dart';

import 'package:flutter/material.dart';


class AllPlansScreen extends StatefulWidget {
  const AllPlansScreen({super.key});

  @override
  State<AllPlansScreen> createState() => _AllPlansScreenState();
}

class _AllPlansScreenState extends State<AllPlansScreen> {
  List<Plan> plans = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPlans();
  }

  Future<void> _fetchPlans() async {
    try {
      final response = await PlanService.fetchPlans(category: 'all');
      setState(() {
        plans = response
            .map((json) => Plan.fromJson(json, () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Selected: ${json['planName']}')),
          );
        }))
            .toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Our Plans"),
        centerTitle: true,
        backgroundColor: const Color(0xFF4A00E0),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : LayoutBuilder(
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
                  child: PlanCard(plan: plan),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
