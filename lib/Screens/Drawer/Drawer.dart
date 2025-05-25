import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final void Function()? onLogout;

  const CustomDrawer({super.key, this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
                ),
              ),
              child: Text(
                'Welcome!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            _gradientDrawerItem(
              icon: Icons.payment,
              title: 'Our Plans',
              onTap: () {},
            ),
            _gradientDrawerItem(
              icon: Icons.update,
              title: 'Renew Your Plan',
              onTap: () {},
            ),
            _gradientDrawerItem(
              icon: Icons.support_agent,
              title: 'Support',
              onTap: () {},
            ),
            _gradientDrawerItem(
              icon: Icons.person,
              title: 'My Profile',
              onTap: () {},
            ),
            _gradientDrawerItem(
              icon: Icons.chat,
              title: 'Talk to Us',
              onTap: () {},
            ),
            _gradientDrawerItem(
              icon: Icons.logout,
              title: 'Logout',
              onTap: onLogout ?? () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _gradientDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        onTap: onTap,
      ),
    );
  }
}
