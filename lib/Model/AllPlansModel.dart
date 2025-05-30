import 'dart:ui';

class Plan {
  final String title;
  final String tagline;
  final String price;
  final String discount;
  final List<String> features;
  final bool isPopular;
  final VoidCallback onTap;

  Plan({
    required this.title,
    required this.tagline,
    required this.price,
    required this.discount,
    required this.features,
    this.isPopular = false,
    required this.onTap,
  });
}
