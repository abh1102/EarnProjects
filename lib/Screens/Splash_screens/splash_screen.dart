import 'dart:async';
import 'dart:math';
import 'package:earnprojects/Screens/Home/HomeScreen.dart';
import 'package:earnprojects/Screens/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../widgets/cards_widges.dart';
import 'cards.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late List<Animation<double>> _cardAnimations;
  late List<Animation<double>> _cardBounceAnimations;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Create staggered animations for each card (rotation)
    _cardAnimations = List.generate(4, (index) {
      return Tween<double>(begin: 0, end: 2 * pi).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(0.2 + index * 0.15, 0.8, curve: Curves.easeInOutBack),
        ),
      );
    });

    // Create bounce animations for each card
    // Create bounce animations for each card
    _cardBounceAnimations = List.generate(4, (index) {
      return TweenSequence<double>([
        TweenSequenceItem(
          tween: Tween(begin: 1.0, end: 1.2), // scale up
          weight: 1.0,
        ),
        TweenSequenceItem(
          tween: Tween(begin: 1.2, end: 0.9), // bounce down
          weight: 1.5,
        ),
        TweenSequenceItem(
          tween: Tween(begin: 0.9, end: 1.0), // return to normal
          weight: 1.0,
        ),
      ]).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(0.3 + index * 0.1, 1.0, curve: Curves.easeOut),
        ),
      );
    });

    _controller.forward();

    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildAnimatedBackground() {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(seconds: 8),
      builder: (context, double value, _) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.purple.withOpacity(0.7 + 0.3 * value),
                Colors.blue.withOpacity(0.7 + 0.3 * value),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLandscape = screenSize.width > screenSize.height;

    return Scaffold(
      body: Stack(
        children: [
          buildAnimatedBackground(),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(isLandscape ? 20 : 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Image.asset(
                          'assets/image/AppIcon.png',
                          width: isLandscape ? screenSize.width * 0.25 : 150,
                          height: isLandscape ? screenSize.width * 0.25 : 150,
                        ),
                      ),
                    ),
                    SizedBox(height: isLandscape ? 15 : 30),
                    buildCardRow(isLandscape),
                    SizedBox(height: isLandscape ? 10 : 20),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: screenSize.width * 0.8,
                      ),
                      child: DefaultTextStyle(
                        style: TextStyle(
                          fontSize: isLandscape
                              ? screenSize.width * 0.04
                              : 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7c3aed),
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              'EarnProjects',
                              speed: Duration(milliseconds: 100),
                            ),
                          ],
                          totalRepeatCount: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget buildCardRow(bool isLandscape) {
    final screenSize = MediaQuery.of(context).size;
    final cardSize = isLandscape
        ? screenSize.width * 0.15
        : screenSize.width * 0.25;

    final cardPadding = isLandscape ? 8.0 : 12.0;
    final textStyle = TextStyle(
      fontSize: cardSize * 0.1,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
    );

    List<List<Widget>> cardRows = [];
    for (var i = 0; i < _cardAnimations.length; i += 3) {
      cardRows.add(
        _cardAnimations.sublist(i, i + 3 > _cardAnimations.length
            ? _cardAnimations.length
            : i + 3)
            .asMap()
            .map((index, _) => MapEntry(
          index,
          Padding(
            padding: EdgeInsets.all(cardPadding),
            child: Card( // Restored Card widget with white background
              elevation: 4, // Add shadow
              color: Colors.white, // White background
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                width: cardSize,
                height: cardSize * 1.2,
                padding: EdgeInsets.all(8), // Inner padding
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      getIconForIndex(i + index),
                      size: cardSize * 0.3,
                      color: Colors.blue, // Icon color
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: cardSize * 0.9,
                      child: Text(
                        getTitleForIndex(i + index),
                        style: textStyle.copyWith(color: Colors.black87), // Text color
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ))
            .values
            .toList(),
      );
    }

    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(0, 1),
        end: Offset(0, 0),
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.2, 0.8, curve: Curves.easeOut),
      )),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: cardRows.map((row) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: row,
          )).toList(),
        ),
      ),
    );
  }// Helper methods for dynamic solution
  IconData getIconForIndex(int index) {
    switch(index) {
      case 0: return Icons.shopping_cart;
      case 1: return Icons.monitor_heart;
      case 2: return Icons.attach_money;
      case 3: return Icons.article;
      default: return Icons.help_outline;
    }
  }

  String getTitleForIndex(int index) {
    switch(index) {
      case 0: return 'E-Commerce';
      case 1: return 'Health Tracker';
      case 2: return 'Finance';
      case 3: return 'Content';
      default: return 'Feature ${index + 1}';
    }
  }
}

// class AnimatedCard extends StatelessWidget {
//   final Animation<double> animation;
//   final Animation<double> bounceAnimation;
//   final String imagePath;
//   final String title;
//
//   const AnimatedCard({
//     required this.animation,
//     required this.bounceAnimation,
//     required this.imagePath,
//     required this.title,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: Listenable.merge([animation, bounceAnimation]),
//       builder: (context, child) {
//         return Transform(
//           transform: Matrix4.identity()
//             ..rotateZ(animation.value) // Rotation animation
//             ..scale(bounceAnimation.value), // Bounce animation
//           alignment: Alignment.center,
//           child: InsuranceCard(
//             imagePath: imagePath,
//             title: title,
//           ),
//         );
//       },
//     );
//   }
// }