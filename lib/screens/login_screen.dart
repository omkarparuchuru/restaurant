import 'package:flutter/material.dart';
import '../widgets/gradient_appbar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const GradientAppBar(title: 'Login'),
      body: Center(
        child: Text(
          'Login Page',
          style: TextStyle(fontSize: w * 0.05, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
