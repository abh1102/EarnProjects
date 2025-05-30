import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../../Model/AllPlansModel.dart';
import 'AllPlansCards.dart';

class AllPlansScreen extends StatelessWidget {
  const AllPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Plan> plans = [
      Plan(
        title: 'Starter Plan',
        tagline: 'Small project leads, good for learning.',
        price: '₹299/month',
        discount: 'Save ₹989.00 annually',
        features: [
          '2-3 project leads per month',
          'Basic project filtering',
          'Email support',
          'Completion certificates',
          'Basic skill assessment',
          'Community access',
        ],
        onTap: () {},
      ),
      Plan(
        title: 'Basic Plan',
        tagline: 'Ideal for earning potential. Kickstart career.',
        price: '₹499/month',
        discount: 'Save ₹1989.00 annually',
        features: [
          '5-7 project leads per month',
          'Advanced project matching',
          'Priority support',
          'Experience letters',
          'Skill workshops',
          'Mentor connection',
          'Portfolio builder',
        ],
        isPopular: true,
        onTap: () {},
      ),
      Plan(
        title: 'Basic Plan',
        tagline: 'Ideal for earning potential. Kickstart career.',
        price: '₹499/month',
        discount: 'Save ₹1989.00 annually',
        features: [
          '5-7 project leads per month',
          'Advanced project matching',
          'Priority support',
          'Experience letters',
          'Skill workshops',
          'Mentor connection',
          'Portfolio builder',
        ],
        isPopular: true,
        onTap: () {},
      ),  Plan(
        title: 'Basic Plan',
        tagline: 'Ideal for earning potential. Kickstart career.',
        price: '₹499/month',
        discount: 'Save ₹1989.00 annually',
        features: [
          '5-7 project leads per month',
          'Advanced project matching',
          'Priority support',
          'Experience letters',
          'Skill workshops',
          'Mentor connection',
          'Portfolio builder',
        ],
        isPopular: true,
        onTap: () {},
      ),

      // Add more plans as needed...
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Our Plans"),
        centerTitle: true,
        backgroundColor: const Color(0xFF4A00E0),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double cardWidth = constraints.maxWidth > 600
              ? (constraints.maxWidth - 36) / 2  // for 2 columns with spacing
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
