import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../widgets/gradient_appbar.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'support_screen.dart';
import 'login_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const GradientAppBar(title: 'More'),
      body: ListView(
        padding: EdgeInsets.all(w * 0.03),
        children: [
          _menuCard(
            context,
            icon: MdiIcons.accountCircleOutline,
            label: 'Profile',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
            },
            w: w,
          ),
          _menuCard(
            context,
            icon: MdiIcons.cogOutline,
            label: 'Settings',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
            },
            w: w,
          ),
          _menuCard(
            context,
            icon: MdiIcons.helpCircleOutline,
            label: 'Support',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SupportScreen()));
            },
            w: w,
          ),
          _menuCard(
            context,
            icon: MdiIcons.logoutVariant,
            label: 'Logout',
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
            },
            w: w,
          ),
        ],
      ),
    );
  }

  Widget _menuCard(BuildContext context,
      {required IconData icon,
        required String label,
        required VoidCallback onTap,
        required double w}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: w * 0.03),
        padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: w * 0.045),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrange.shade200, Colors.orange.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.deepOrange.shade100.withOpacity(0.5),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(w * 0.035),
              decoration: BoxDecoration(
                color: Colors.deepOrange.shade400,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: w * 0.08),
            ),
            SizedBox(width: w * 0.05),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: w * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange.shade900,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: w * 0.045,
              color: Colors.deepOrange.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
