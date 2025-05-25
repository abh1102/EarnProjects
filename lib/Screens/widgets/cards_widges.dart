import 'package:flutter/material.dart';

import '../Splash_screens/cards.dart';
// Widget buildCardRow(Animation<double> animation) {
//
//   return SlideTransition(
//     position: Tween<Offset>(
//       begin: Offset(0, 1), // from bottom
//       end: Offset(0, 0),   // to center
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Interval(0.2, 0.8, curve: Curves.easeOut),
//     )),
//     child: FadeTransition(
//       opacity: _fadeAnimation,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           InsuranceCard(
//             imagePath: 'assets/icons/umbrella.png',
//             title: 'Term Life\nInsurance',
//           ),
//           InsuranceCard(
//             imagePath: 'assets/icons/heart.png',
//             title: 'Health\nInsurance',
//           ),
//           // Add more cards here if needed
//         ],
//       ),
//     ),
//   );
// }
class AnimatedCard extends StatelessWidget {
  final Animation<double> animation;
  final Animation<double> bounceAnimation;
  final IconData icon;
  final String title;

  const AnimatedCard({
    required this.animation,
    required this.bounceAnimation,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([animation, bounceAnimation]),
      builder: (context, child) {
        return Transform(
          transform: Matrix4.identity()
            ..rotateZ(animation.value)
            ..scale(bounceAnimation.value),
          alignment: Alignment.center,
          child: InsuranceCard(
            icon: icon,
            title: title,
          ),
        );
      },
    );
  }
}