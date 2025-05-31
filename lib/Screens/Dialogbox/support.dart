import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDialog extends StatelessWidget {
  const ContactDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final double dialogWidth = MediaQuery
        .of(context)
        .size
        .width * 0.8;

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
                Icons.chat,
                'WhatsApp',
                openWhatsApp,
              ),
              _buildPlanItem(
                context,
                Icons.mail_outline,
                'Mail Us',
                openMail,
              ),
              _buildPlanItem(
                context,
                Icons.call,
                'Connect With Us',
                openDialer,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanItem(BuildContext context, IconData icon, String label,
      VoidCallback onTap) {
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

  Future<void> openWhatsApp() async {
    final Uri url = Uri.parse('https://wa.me/9835490474?text=Hello');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      print("WhatsApp not available");
    }
  }

  Future<void> openMail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'abhishekjha2507@gmail.com',
      queryParameters: {'subject': 'Need Help Regarding App Issue'},
    );
    if (!await launchUrl(emailUri, mode: LaunchMode.externalApplication)) {
      print("Email app not available");
    }
  }

  Future<void> openDialer() async {
    final Uri telUri = Uri.parse('tel:9835490474');
    if (!await launchUrl(telUri, mode: LaunchMode.externalApplication)) {
      print("Dialer not available");
    }
  }
}
