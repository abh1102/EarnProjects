import 'package:flutter/material.dart';

import '../../Model/projectLeads.dart';
import 'ProjectLeads.dart';
class ProjectLeadsScreen extends StatelessWidget {
  ProjectLeadsScreen({super.key});

  final List<ProjectLeadModel> projectLeads = [
    ProjectLeadModel(
      label: 'Sample Project Lead',
      title: 'E-commerce Website Development',
      subtitle: 'Perfect for students to gain real-world experience',
      budget: '\$1,000 - \$2,000',
      duration: '2-3 weeks',
    ),
    ProjectLeadModel(
      label: 'Sample Project Lead',
      title: 'Mobile App for Grocery Delivery',
      subtitle: 'Build a full-stack Flutter app with Firebase',
      budget: '\$1,500 - \$2,500',
      duration: '3-4 weeks',
    ),
    ProjectLeadModel(
      label: 'Sample Project Lead',
      title: 'Portfolio Website for Freelancer',
      subtitle: 'Simple yet professional portfolio site',
      budget: '\$300 - \$700',
      duration: '1-2 weeks',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Project Leads'),          backgroundColor: const Color(0xFF4A00E0),
      ),
      body: ListView.builder(
        itemCount: projectLeads.length,
        itemBuilder: (context, index) {
          return ProjectLeadCard(data: projectLeads[index]);
        },
      ),
    );
  }
}
