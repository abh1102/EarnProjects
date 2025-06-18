import 'dart:ui';

// models/plan_model.dart

class Plan {
  final String title;
  final String tagline;
  final String price;
  final String discount;
  final List<String> features;
  final bool isPopular;
  final String category;
  final int noOfLeads;

  final VoidCallback onTap;

  Plan({
    required this.title,
    required this.tagline,
    required this.price,
    required this.discount,
    required this.features,
    required this.isPopular,
    required this.category,
    required this.noOfLeads,
    required this.onTap,
  });

  factory Plan.fromJson(Map<String, dynamic> json, VoidCallback onTap) {
    return Plan(
      title: json['planName'] ?? '',
      tagline: json['planDescription'] ?? '',
      price: '₹${json['price'].toString()}',
      discount: '₹${json['discount'].toString()}',
      features: List<String>.from(json['features']),
      isPopular: json['popular'] ?? false,
      category: json['category'] ?? '',
      noOfLeads: json['noOfLeads'] ?? 0,
      onTap: onTap,
    );
  }
}
