import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/functions/app_setting_method.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("app_title".tr())),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Hi from Theme mode"),
            const SizedBox(height: 32),
            const Text("ازيكم يا جماعة"),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  switchTheme(context);
                },
                child: const Text("Switch Theme"),
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () => switchLanguage(context),
                child: const Text("Switch Language"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
