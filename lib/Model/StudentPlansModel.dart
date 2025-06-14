import 'package:earnprojects/Screens/StudentPlans/forms_after_choosingPlans_students.dart';
import 'package:flutter/material.dart';

import 'AllPlansModel.dart';
// models/student_plans_model.dart
class StudentPlans {
  static List<Plan> getPlans(BuildContext context) {
    return [
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
        onTap: () => _navigateToCheckout(context, 0),
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
        onTap: () => _navigateToCheckout(context, 1),
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
        onTap: () => _navigateToCheckout(context, 2),
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
        onTap: () => _navigateToCheckout(context, 3),
      ),
    ];
  }

  static void _navigateToCheckout(BuildContext context, int planIndex) {
    final plans = getPlans(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentsCheckoutScreen(plan: plans[planIndex]),
      ),
    );
  }

}