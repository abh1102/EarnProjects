import 'package:flutter/material.dart';
class AgencyScreen extends StatelessWidget {
  const AgencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agency')),
      body: const Center(child: Text('Agency Content')),
    );
  }
}