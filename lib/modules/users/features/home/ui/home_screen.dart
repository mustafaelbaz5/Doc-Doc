import '../../../../../core/utils/functions/app_setting_method.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return const Scaffold(
      body: Center(
        child: TextButton(onPressed: logout, child: Text('Home')),
      ),
    );
  }
}
