import 'package:flutter/material.dart';
import '../widgets/gradient_appbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const GradientAppBar(title: 'Settings'),
      body: Center(
        child: Text(
          'Settings Page',
          style: TextStyle(fontSize: w * 0.05, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
