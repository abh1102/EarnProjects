import 'package:earnprojects/Screens/Home/showcaseCards.dart';
import 'package:earnprojects/Screens/ProjectLeads/ViewLeadsScreen.dart';
import 'package:earnprojects/Screens/Signup/SignUp.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'CardsInHome.dart';
import 'WebView.dart';

class ShowcaseHomePage extends StatelessWidget {
  const ShowcaseHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Unlock Your Potential.',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.purple, Colors.blue, Colors.teal],
            ).createShader(bounds),
            child: const Text(
              'Earn, Grow, and\nSucceed.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Real projects | Real Earnings | Real Freedom',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7A1FFF),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            icon: const Icon(Icons.arrow_forward),
            label: const Text(
              'Subscribe Now',
              style: TextStyle(fontSize: 16,color: Colors.white70),
            ),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProjectLeadsScreen()));
            },
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              side: const BorderSide(color: Colors.black12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'View Sample Leads',
              style: TextStyle(fontSize: 16),
            ),
          ),


          const SizedBox(height: 30),
          const Text(
            'Why Choose Our Platform?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
       const   SizedBox(height: 20,),
         const Text(
            'Get access to verified project leads and grow your career or business.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),

          const ShowcaseCard(
            icon: Icons.school,
            title: 'For Students',
            subtitle: 'Gain experience & earn while learning',
            startColor: Color(0xFF8B5CF6),
            endColor: Color(0xFF7C3AED),
          ),
          const ShowcaseCard(
            icon: Icons.work_outline,
            title: 'For Professionals',
            subtitle: 'Find high-paying side projects',
            startColor: Color(0xFF6366F1),
            endColor: Color(0xFF4F46E5),
          ),
          const ShowcaseCard(
            icon: Icons.apartment,
            title: 'For Agencies',
            subtitle: 'Scale your business with qualified leads',
            startColor: Color(0xFF10B981),
            endColor: Color(0xFF059669),
          ),
          const SizedBox(height: 20),

          // Why Choose Us Cards
          const WhyChooseCard(
            icon: Icons.verified,
            title: 'Verified Projects',
            subtitle:
            'Every lead is thoroughly vetted to ensure quality and authenticity',
          ),
          const WhyChooseCard(
            icon: Icons.access_time,
            title: 'Flexible Work',
            subtitle:
            'Choose projects that match your schedule and expertise',
          ),
          const WhyChooseCard(
            icon: Icons.headset_mic,
            title: 'Guaranteed Support',
            subtitle: '24/7 support to help you succeed with your projects',
          ),
          const WhyChooseCard(
            icon: Icons.show_chart,
            title: 'Growth Opportunities',
            subtitle:
            'Access to training, certifications, and networking events',
          ),
          const SizedBox(height: 40),
          Column(
            children: [
              const SizedBox(height: 8),
              Text(
                "🤝 Connect With Us",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Follow us on social media and stay updated with the latest\nopportunities and tips!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialIconButton(
                    context,
                    FontAwesomeIcons.linkedin,

                    'https://www.linkedin.com/company/earnprojects/?viewAsMember=true',
                    'LinkedIn',
                    Colors.blue.shade800

                  ),
                  const SizedBox(width: 20),
                  _socialIconButton(
                    context,
                    FontAwesomeIcons.instagram,
                    'https://www.instagram.com/earn_project/#',
                    'Instagram',
                    Colors.pinkAccent

                  ),
                  const SizedBox(width: 20),
                  _socialIconButton(
                    context,
                    FontAwesomeIcons.facebook,
                    'https://www.facebook.com/people/EarnProjects/61577005977454/',
                    'Facebook',
                    Colors.blue.shade700,
                  ),
                  const SizedBox(width: 20),
                  _socialIconButton(
                    context,
                    FontAwesomeIcons.youtube,
                    'https://www.youtube.com/@EarnPROJECTSSS',
                    'YouTube',
                    Colors.redAccent,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),

        ],
      ),
    );
  }
  Widget _socialIconButton(BuildContext context,IconData icon, String url, String title,Color color) {
    return GestureDetector(
      onTap: () {
        print("Tapped on ${title}, opening URL: $url");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => WebViewScreen(url: url, title: title),
          ),
        );
      },
      child: CircleAvatar(
        radius: 28,
        backgroundColor: Colors.grey[200],
        child: CircleAvatar(
          radius: 26,
           backgroundColor: color.withOpacity(0.15),
          child: Icon(
            icon,
            size: 30,
             color: color,
          ),
        ),
      ),
    );
  }

}
