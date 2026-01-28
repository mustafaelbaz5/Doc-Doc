import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Center(child: Text("Login Screen"))),
    );
  }
}
