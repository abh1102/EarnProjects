import 'package:earnprojects/Screens/Home/HomeScreen.dart';
import 'package:earnprojects/Screens/Login/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // Add this package

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<Map<String, String>> pages = [
    {
      'image': 'assets/image/img.png',
      'title': 'Students',
      'subtitle': 'Gain experience & earn while learning',
    },
    {
      'image': 'assets/image/img.png',
      'title': 'Professionals',
      'subtitle': 'Find high-paying side projects',
    },
    {
      'image': 'assets/image/img.png',
      'title': 'Agencies',
      'subtitle': 'Scale your business with qualified leads.',
    },
  ];

  int currentIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() => currentIndex = index);
                },
                itemBuilder: (context, index) {
                  final page = pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Image.asset(
                            page['image']!,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          flex: 4,
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            margin: const EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white.withOpacity(0.3)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  page['title']!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  page['subtitle']!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Positioned(
                top: 20,
                right: 20,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 100,
                left: 0,
                right: 0,
                child: Center(
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: pages.length,
                    effect: WormEffect(
                      dotColor: Colors.white38,
                      activeDotColor: Colors.white,
                      dotHeight: 10,
                      dotWidth: 10,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                right: 24,
                child: GestureDetector(
                  onTap: () {
                    if (currentIndex < pages.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    }
                  },
                  child: Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Colors.pinkAccent, Colors.deepPurpleAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



//
// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});
//
//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }
//
// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final Z<Map<String, dynamic>> pages = [
//     {
//       'image':
//       'https://images.unsplash.com/photo-1588072432836-e10032774350?auto=format&fit=crop&w=800&q=80',
//       'captionTitle': 'Find Your Next Big Project Opportunity',
//     },
//     {
//       'image':
//       'https://images.unsplash.com/photo-1551434678-e076c223a692?auto=format&fit=crop&w=800&q=80',
//       'captionTitle':
//       'Get notified about new projects before they are publicly available, giving you a competitive advantage.',
//     },
//     {
//       'image':
//       'https://images.unsplash.com/photo-1551434678-e076c223a692?auto=format&fit=crop&w=800&q=80',
//       'captionTitle':
//       'Customize your feed to receive projects relevant to your skills, industry, and preferences.',
//     },
//   ];
//
//   int currentIndex = 0;
//   late final PageController _pageController;
//
//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           PageView.builder(
//             controller: _pageController,
//             itemCount: pages.length,
//             onPageChanged: (index) {
//               setState(() {
//                 currentIndex = index;
//               });
//             },
//             itemBuilder: (context, index) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(16),
//                       child: Image.network(
//                         pages[index]['image'],
//                         height: MediaQuery.of(context).size.height * 0.4,
//                         width: MediaQuery.of(context).size.width * 0.8,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Text(
//                         pages[index]['captionTitle'] ?? '',
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           fontFamily: 'Poppins',
//                           fontWeight: FontWeight.w400,
//                           fontStyle: FontStyle.italic,
//                           fontSize: 20,
//                           color: Colors.purpleAccent,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//           Positioned(
//             bottom: 20,
//             left: 20,
//             child: TextButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const LoginScreen()),
//                 );
//               },
//               child: const Text(
//                 'Skip',
//                 style: TextStyle(
//                   color: Colors.black87,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 20,
//             right: 20,
//             child: ElevatedButton(
//               onPressed: () {
//                 if (currentIndex < pages.length - 1) {
//                   _pageController.nextPage(
//                     duration: const Duration(milliseconds: 300),
//                     curve: Curves.easeInOut,
//                   );
//                 } else {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const LoginScreen()),
//                   );
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blueAccent,
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: Text(
//                 currentIndex < pages.length - 1 ? 'Next' : 'Done',
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// Dummy ChooseRole widget for navigation. Replace with your actual screen.
