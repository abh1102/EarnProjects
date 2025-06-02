import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../Home/HomeScreen.dart';

class FAQScreen extends StatelessWidget {
  FAQScreen({super.key});

  final List<FAQ> faqList = [
    FAQ(
      question: "How do the project leads work?",
      answer:
      "We source and verify real project opportunities from businesses and individuals. Once subscribed, you'll receive leads matching your expertise and preferences directly in your dashboard.",
    ),
    FAQ(
      question: "Is there a free trial available?",
      answer:
      "Yes! We offer a 14-day free trial on all plans. You'll get access to sample project leads to understand how the platform works.",
    ),
    FAQ(
      question: "Can I cancel my subscription at any time?",
      answer:
      "Absolutely. You can cancel your subscription at any time from your account settings. You'll continue to have access until the end of your current billing period.",
    ),
    FAQ(
      question: "How are project leads verified?",
      answer:
      "Our team thoroughly vets each project lead through a comprehensive verification process, checking client authenticity, project scope, and budget to ensure quality opportunities.",
    ),
    FAQ(
      question: "What happens if I don't use all my monthly leads?",
      answer:
      "Unused leads from your monthly quota expire at the end of each billing cycle. We encourage active participation to make the most of your subscription.",
    ),
  ];

  final List<List<Color>> gradientList = [
     [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
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
        backgroundColor: const Color(0xFF4A00E0),
      ),
      body: ListView.builder(
        itemCount: faqList.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final faq = faqList[index];
          final gradientColors = gradientList[index % gradientList.length];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,

                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: ExpansionTile(
                  collapsedIconColor: Colors.white,
                  iconColor: Colors.white,
                  tilePadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  title: Text(
                    faq.question,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  children: [
                    Container(
                      color: Colors.white.withOpacity(0.95),
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        faq.answer,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FAQ {
  final String question;
  final String answer;

  FAQ({required this.question, required this.answer});
}
