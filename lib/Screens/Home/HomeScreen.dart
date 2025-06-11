import 'package:flutter/material.dart';
import '../BottomSheet/bottomShet.dart';
import '../Drawer/Drawer.dart';

import 'package:flutter/material.dart';
import '../Drawer/Drawer.dart';
import '../Agency/Agency.dart';
import '../Professionals/Professionals.dart';
import '../StudentPlans/Students.dart';
import 'homepage2.dart';
class MainContainerScreen extends StatefulWidget {
  const MainContainerScreen({super.key});

  @override
  State<MainContainerScreen> createState() => _MainContainerScreenState();
}

class _MainContainerScreenState extends State<MainContainerScreen> {
  int selectedIndex = -1;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget _getBody() {
    switch (selectedIndex) {
      case 0:
        return const ProfessionalScreen();
      case 1:
        return const StudentScreen();
      case 2:
        return const AgencyScreen();
      default:
        return const ShowcaseHomePage(); // 🔁 here
    }
  }

  String _getAppBarTitle() {
    switch (selectedIndex) {
      case 0:
        return 'Professional';
      case 1:
        return 'Student';
      case 2:
        return 'Agency';
      default:
        return 'Home'; // For ShowcaseHomePage
    }
  }
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle()),
        backgroundColor: const Color(0xFF4A00E0),
      ),
      drawer: CustomDrawer(
        onLogout: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logged out')),
          );
        },
      ),
      body: Stack(
        children: [
          _getBody(),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  selectedIndex = -1;
                });
              },
              label: const Text('Home'),
              icon: const Icon(Icons.home),
              backgroundColor: Colors.blueAccent,
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

}

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   void _navigateTo(BuildContext context, int index) {
//     switch (index) {
//       case 0:
//         Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfessionalScreen()));
//         break;
//       case 1:
//         Navigator.push(context, MaterialPageRoute(builder: (_) => const StudentScreen()));
//         break;
//       case 2:
//         Navigator.push(context, MaterialPageRoute(builder: (_) => const AgencyScreen()));
//         break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: CustomDrawer(onLogout: () {
//         Navigator.pop(context);
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Logged out')),
//         );
//       }),
//       appBar: AppBar(
//         title: const Text('Welcome'),
//         backgroundColor: const Color(0xFF4A00E0),
//       ),
//       body: const Center(
//         child: Text(
//           'Welcome to the App! This is the Showcase Home Page.',
//           style: TextStyle(fontSize: 22),
//           textAlign: TextAlign.center,
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNavBar(
//         selectedIndex: -1, // Nothing is selected yet
//         onItemTapped: (index) => _navigateTo(context, index),
//       ),
//     );
//   }
// }
