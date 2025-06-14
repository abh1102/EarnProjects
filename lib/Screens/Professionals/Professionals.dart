import 'package:earnprojects/Screens/Professionals/ProfessionalCards.dart';
import 'package:flutter/material.dart';

import '../../Model/AllPlansModel.dart';
class ProfessionalScreen extends StatelessWidget {

  const ProfessionalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Plan> plans = [

      Plan(
        title: 'Basic Plan',
        tagline: 'Projects matching your experience level.',
        price: '₹999/month',
        discount: 'Save ₹1189.00 annually',
        features: [
          'Access to entry-level project leads',
          'Email support',
          'Profile visibility to clients',
          'Basic project filtering',
        ],
        isPopular: true,
        onTap: () {},
      ),

      Plan(
        title: 'Silver Plan',
        tagline: 'Ideal for earning potential. Kickstart career.',
        price: '₹4,999/month',
        discount: 'Save ₹2389.00 annually',
        features: [
          'Access to mid-level project leads',
          'Better project payout opportunities'
          'Priority email support',
          'Project performance tracking',
          'Resume builder tools'

        ],
        isPopular: true,
        onTap: () {},
      ),  Plan(
        title: 'Gold Plan',
        tagline: 'Ideal for earning potential. Kickstart career.',
        price: '₹9999/month',
        discount: 'Save ₹4989.00 annually',
        features: [
      'Leads from premium clients',
      'Occasional team collaboration projects',
      'Profile badge for top professionals'
      'Direct client messaging',
      'Networking opportunities',
      'Advanced project analytic'
        ],
        isPopular: true,
        onTap: () {},
      ),
      Plan(
        title: 'Pro Plan',
        tagline: 'Ideal for earning potential. Kickstart career.',
        price: '₹19,999/month',
        discount: 'Save ₹9989.00 annually',
        features: [
          'All-access project leads',
          'Personal branding assistance',
          'Skill development programs',
          'Dedicated success manager',
          'Lead prioritization support',
          'Freelancer toolkit and templates'

        ],
        isPopular: true,
        onTap: () {},
      ),
      // Add more plans as needed...
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Plans For Professionals'),
        backgroundColor: const Color(0xFF4D90FE),
        elevation: 0,
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
                  child: Professionalcards(plan: plan),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: const Text('Professional')),
  //     body: const Center(child: Text('Professional Content')),
  //   );
  // }
}


