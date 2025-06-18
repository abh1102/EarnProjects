// models/professional_plans_model.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Screens/Professionals/Forms_After_Choosing_Plans.dart';
import 'AllPlansModel.dart';

class ProfessionalPlans {
  static List<Plan> getPlans(BuildContext context) {
    return [
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
        onTap: () => _navigateToCheckout(context, 0), category: '', noOfLeads: 2,
      ),
      Plan(
        title: 'Silver Plan',
        tagline: 'Ideal for earning potential. Kickstart career.',
        price: '₹4,999/month',
        discount: 'Save ₹2389.00 annually',
        features: [
          'Access to mid-level project leads',
          'Better project payout opportunities',
          'Priority email support',
          'Project performance tracking',
          'Resume builder tools',
        ],
        isPopular: true,
        onTap: () => _navigateToCheckout(context, 1), category: '', noOfLeads: 2,
      ),
      Plan(
        title: 'Gold Plan',
        tagline: 'Ideal for earning potential. Kickstart career.',
        price: '₹50000/month',
        discount: 'Save ₹4989.00 annually',
        features: [
          'Leads from premium clients',
          'Occasional team collaboration projects',
          'Profile badge for top professionals',
          'Direct client messaging',
          'Networking opportunities',
          'Advanced project analytic',
        ],
        isPopular: true,
        onTap: () => _navigateToCheckout(context, 2), category: '', noOfLeads: 2,
      ),
    ];
  }

  static void _navigateToCheckout(BuildContext context, int planIndex) {
    final plans = getPlans(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfessionCheckoutScreen(plan: plans[planIndex]),
      ),
    );
  }
}