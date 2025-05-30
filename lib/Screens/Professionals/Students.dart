import 'package:flutter/material.dart';
class StudentScreen extends StatelessWidget {
  const StudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student')),
      body: const Center(child: Text('Student Content')),
    );
  }
}
