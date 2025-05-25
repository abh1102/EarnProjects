import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../Drawer/Drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _handleLogout(BuildContext context) {
    // Add logout logic here
    Navigator.pop(context); // Close drawer
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logged out')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(onLogout: () => _handleLogout(context)),
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: const Color(0xFF4A00E0),
      ),
      body: const Center(
        child: Text(
          'Welcome to Home Page',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
