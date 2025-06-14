import 'package:flutter/material.dart';

import '../../Model/AllPlansModel.dart';
import 'StudentCardsPlan.dart';
class StudentScreen extends StatelessWidget {
  const StudentScreen({super.key});

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
        tagline: 'Real-world tasks with earning potential. Kickstart your career',
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
        title: 'Advanced Plan',
        tagline: 'More frequent project leads. Build your portfolio faster.',
        price: '₹799/month',
        discount: 'Save ₹2989.00 annually',
        features: [
          '7-10 project leads per month',
          'Advanced project filtering',
          'Priority support',
          'Client communication tools',
          'Professional profile badge',
          'Training programs access',
        ],
        isPopular: true,
        onTap: () {},
      ),
      Plan(
        title: 'Pro Plan',
        tagline: 'Premium projects + experience letters on completion + support to close clients',
        price: '₹1299/month',
        discount: 'Save ₹4989.00 annually',
        features: [
          'Unlimited project leads',
          'Team management tools',
          'Dedicated support',
          'Experience letters',
          'Invoice & billing system',
          'Custom branding',
          'Agency analytics dashboard',
        ],
        isPopular: true,
        onTap: () {},
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Plans For Students'),
        backgroundColor: const Color(0xFF4D90FE),
        elevation: 0,
      ),
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
                  child: StudentCardsPlan(plan: plan),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
