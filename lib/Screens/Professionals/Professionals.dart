import 'package:earnprojects/Screens/Professionals/Forms_After_Choosing_Plans.dart';
import 'package:earnprojects/Screens/Professionals/ProfessionalCards.dart';
import 'package:flutter/material.dart';

import '../../Model/AllPlansModel.dart';
// screens/professional_screen.dart
import '../../Model/ProfessionalsPlans.dart';

class ProfessionalScreen extends StatefulWidget {
  const ProfessionalScreen({super.key});

  @override
  State<ProfessionalScreen> createState() => _ProfessionalScreenState();
}

class _ProfessionalScreenState extends State<ProfessionalScreen> {
  late Future<List<Plan>> _plansFuture;

  @override
  void initState() {
    super.initState();
    _plansFuture = ProfessionalPlans.fetchPlans(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Professional Plans")),
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
                      child: Professionalcards(plan: plan),
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
// class ProfessionalScreen extends StatelessWidget {
//   const ProfessionalScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Use the model's Plan class and define your plans here
//     final List<Plan> plans = [
//       Plan(
//         title: 'Basic Plan',
//         tagline: 'Projects matching your experience level.',
//         price: '₹999/month',
//         discount: 'Save ₹1189.00 annually',
//         features: [
//           'Access to entry-level project leads',
//           'Email support',
//           'Profile visibility to clients',
//           'Basic project filtering',
//         ],
//         isPopular: true,
//         onTap: () {}, // This will be updated below
//       ),
//       Plan(
//         title: 'Silver Plan',
//         tagline: 'Ideal for earning potential. Kickstart career.',
//         price: '₹4,999/month',
//         discount: 'Save ₹2389.00 annually',
//         features: [
//           'Access to mid-level project leads',
//           'Better project payout opportunities',
//           'Priority email support',
//           'Project performance tracking',
//           'Resume builder tools',
//         ],
//         isPopular: true,
//         onTap: () {}, // This will be updated below
//       ),
//       Plan(
//         title: 'Gold Plan',
//         tagline: 'Ideal for earning potential. Kickstart career.',
//         price: '₹9999/month',
//         discount: 'Save ₹4989.00 annually',
//         features: [
//           'Leads from premium clients',
//           'Occasional team collaboration projects',
//           'Profile badge for top professionals',
//           'Direct client messaging',
//           'Networking opportunities',
//           'Advanced project analytic',
//         ],
//         isPopular: true,
//         onTap: () {}, // This will be updated below
//       ),
//     ].map((plan) {
//       // Create a new plan with the correct onTap handler that captures the current plan
//       return Plan(
//         title: plan.title,
//         tagline: plan.tagline,
//         price: plan.price,
//         discount: plan.discount,
//         features: plan.features,
//         isPopular: plan.isPopular,
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ProfessionCheckoutScreen(plan: plan),
//             ),
//           );
//         },
//       );
//     }).toList();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Plans For Professionals'),
//         backgroundColor: const Color(0xFF4D90FE),
//         elevation: 0,
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           double cardWidth = constraints.maxWidth > 600
//               ? (constraints.maxWidth - 36) / 2
//               : constraints.maxWidth;
//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(12),
//             child: Wrap(
//               spacing: 12,
//               runSpacing: 12,
//               children: plans.map((plan) {
//                 return SizedBox(
//                   width: cardWidth,
//                   child: GestureDetector(
//                     onTap: plan.onTap,
//                     child: Professionalcards(plan: plan),
//                   ),
//                 );
//               }).toList(),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }



