import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import '../AllPlans/AllPlansScreen.dart';

class PlansDropdownDialog extends StatelessWidget {
  const PlansDropdownDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final double dialogWidth = MediaQuery.of(context).size.width * 0.8;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Center(
        child: Container(
          width: dialogWidth,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPlanItem(
                context,
                Icons.list_alt_outlined,
                'All Plans',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AllPlansScreen()),
                    )
              ),
              _buildPlanItem(
                context,
                Icons.school_outlined,
                'Student Plans',
                    () => Navigator.pop(context),
              ),
              _buildPlanItem(
                context,
                Icons.work_outline,
                'Professional Plans',
                    () => Navigator.pop(context),
              ),
              _buildPlanItem(
                context,
                Icons.apartment_outlined,
                'Agency Plans',
                    () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanItem(
      BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white, size: 28),
      title: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      hoverColor: Colors.white.withOpacity(0.1),
    );
  }
}
