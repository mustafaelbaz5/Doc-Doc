import 'package:doc_doc/core/constants/storage_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/dependency_injection.dart';
import 'core/router/app_router.dart';
import 'doc_doc_app.dart';

void main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Future.wait([
    EasyLocalization.ensureInitialized(),
    setupHydratedStorage(),
    setUpDependencies(),
  ]);

  await setUpDependencies();
  await ScreenUtil.ensureScreenSize();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      startLocale: const Locale('en'),
      fallbackLocale: const Locale('en'),
      child: DocDocApp(appRouter: AppRouter()),
    ),
  );
}
