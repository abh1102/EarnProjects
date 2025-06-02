import 'package:earnprojects/Screens/Testimonials/testimonials.dart';
import 'package:flutter/material.dart';

import '../../Model/Testimonials.dart';
import '../Home/HomeScreen.dart';
class TestimonialScreen extends StatelessWidget {

  TestimonialScreen({super.key});

  final List<Testimonial> testimonials = [
    Testimonial(
      name: "Prem Patel",
      role: "Freelance Designer, \nIndependent Professional",
      imageUrl: "https://i.pravatar.cc/150?img=3", // placeholder image
      feedback:
      "This platform has been instrumental in scaling our agency. The premium plan provides exactly the kind of high-value leads we need, and the white-label feature is a game-changer.",
    ),
    Testimonial(
      name: "Anita Rao",
      role: "Startup Consultant",
      imageUrl: "https://i.pravatar.cc/150?img=5",
      feedback:
      "Absolutely love the flexibility! Our client acquisition has doubled. Can’t recommend this platform enough.",
    ),
    // Add more as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Testimonials"),
        backgroundColor: const Color(0xFF4A00E0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Replace current screen with MainContainerScreen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainContainerScreen()),
            );
          },
        ),
      ),
      body: ListView.builder(
        itemCount: testimonials.length,
        itemBuilder: (context, index) {
          return TestimonialCard(testimonial: testimonials[index]);
        },
      ),
    );
  }
}


