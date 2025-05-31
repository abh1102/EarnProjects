import 'package:earnprojects/Screens/Agency/AgencyCards.dart';
import 'package:flutter/material.dart';

import '../../Model/AllPlansModel.dart';
class AgencyScreen extends StatelessWidget {
  const AgencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Plan> plans = [

      Plan(
        title: 'Basic Plan',
        tagline: 'Get consistent leads to keep your team busy.',
        price: '₹9999/month',
        discount: 'Save ₹11,989.00 annually',
        features: [
         'Consistent project leads for your agency',
         'Team account access'
         'Email support',
         'Basic agency dashboard',
         'Client communication tools',
        ],
        isPopular: true,
        onTap: () {},
      ),

      Plan(
        title: 'Silver Plan',
        tagline: 'Leads + occasional sales support.',
        price: '₹19,999/month',
        discount: 'Save ₹23,989.00 annually',
        features: [
          'All Basic features',
          'Increased lead volume',
          'Occasional sales pitch support',
          'Agency performance reports'
          'Access to verified client'

        ],
        isPopular: true,
        onTap: () {},
      ),  Plan(
        title: 'Gold Plan',
        tagline: 'High-ticket client leads. Grow revenue.',
        price: '₹49,999/month',
        discount: 'Save ₹59,989.00 annually',
        features: [
        'High-ticket client leads',
      'Advanced filtering for large projects',
      'Project negotiation support',
      'Dedicated account manager',
      'Client rating & review insights'
        ],
        isPopular: true,
        onTap: () {},
      ),
      Plan(
        title: 'Premium Member Plan',
        tagline: 'Exclusive, high-value leads + full support to manage and close clients.',
        price: '₹99,999/month',
        discount: 'Save ₹1,19,9989.00 annually',
        features: [
          'Exclusive access to premium leads',
          'Full client closing support',
          'Advanced CRM tools',
          'Agency branding & marketing help',
          'Client contract management',
          'Dedicated growth advisor'

        ],
        isPopular: true,
        onTap: () {},
      ),
      // Add more plans as needed...
    ];

    return Scaffold(


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
                  child: AgencyCards(plan: plan),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}