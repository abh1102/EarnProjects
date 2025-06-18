import 'package:flutter/material.dart';

import '../Screens/Agency/Forms_afterchoosing_Plans_Agency.dart';
import 'AllPlansModel.dart';
// models/agency_plans_model.dart
class AgencyPlans {
  static List<Plan> getPlans(BuildContext context) {
    return [
      Plan(
        title: 'Basic Plan',
        tagline: 'Get consistent leads to keep your team busy.',
        price: '₹9999/month',
        discount: 'Save ₹11,989.00 annually',
        features: [
          'Consistent project leads for your agency',
          'Team account access',
          'Email support',
          'Basic agency dashboard',
          'Client communication tools',
        ],
        isPopular: true,
        onTap: () => _navigateToCheckout(context, 0), category: '', noOfLeads:2 ,
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
          'Agency performance reports',
          'Access to verified clients',
        ],
        isPopular: true,
        onTap: () => _navigateToCheckout(context, 1), category: '', noOfLeads: 2,
      ),
      Plan(
        title: 'Gold Plan',
        tagline: 'High-ticket client leads. Grow revenue.',
        price: '₹49,999/month',
        discount: 'Save ₹59,989.00 annually',
        features: [
          'High-ticket client leads',
          'Advanced filtering for large projects',
          'Project negotiation support',
          'Dedicated account manager',
          'Client rating & review insights',
        ],
        isPopular: true,
        onTap: () => _navigateToCheckout(context, 2), category: '', noOfLeads: 2,
      ),
      Plan(
        title: 'Premium Member Plan',
        tagline: 'Exclusive, high-value leads + full support to manage and close clients.',
        price: '₹99,999/month',
        discount: 'Save ₹1,19,989.00 annually',
        features: [
          'Exclusive access to premium leads',
          'Full client closing support',
          'Advanced CRM tools',
          'Agency branding & marketing help',
          'Client contract management',
          'Dedicated growth advisor',
        ],
        isPopular: true,
        onTap: () => _navigateToCheckout(context, 3), category: '', noOfLeads: 2,
      ),
    ];
  }

  static void _navigateToCheckout(BuildContext context, int planIndex) {
    final plans = getPlans(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AgencyCheckoutScreen(plan: plans[planIndex]),
      ),
    );
  }

}