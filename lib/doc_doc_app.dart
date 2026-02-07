import 'package:doc_doc/core/auth/logic/cubit/auth_cubit.dart';
import 'package:doc_doc/core/di/dependency_injection.dart';
import 'package:doc_doc/core/extensions/context_extensions.dart';
import 'package:doc_doc/core/ui/dialogs/app_dialogs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/router/app_router.dart';
import 'core/router/routes.dart';
import 'core/themes/cubit/theme_cubit.dart';
import 'core/themes/theme_data/theme_data_dark.dart';
import 'core/themes/theme_data/theme_data_light.dart';

class DocDocApp extends StatelessWidget {
  const DocDocApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(final BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (final BuildContext context, final Widget? child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (final context) => ThemeCubit()),
            BlocProvider.value(value: getIt<AuthCubit>()),
          ],
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (final BuildContext context, final ThemeMode mode) {
              FlutterNativeSplash.remove();
              return BlocListener<AuthCubit, AuthState>(
                listener: (final context, final state) {
                  // Handle session expiry globally
                  if (state is AuthSessionExpired) {
                    AppDialogs.showCustomDialog(
                      context,
                      title: 'Session Expired',
                      message: 'Your session has expired. Please login again.',
                      buttonText: 'ok',
                      onPressed: () =>
                          context.pushNamedAndRemoveAll(Routes.loginScreen),
                    );
                  }
                },
                child: MaterialApp(
                  key: ValueKey(context.locale),
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  debugShowCheckedModeBanner: false,
                  initialRoute: _getInitialRoute(),
                  onGenerateRoute: appRouter.generateRoute,
                  title: 'DocDoc',
                  theme: getLightTheme(context: context),
                  darkTheme: getDarkTheme(context: context),
                  themeMode: mode,
                ),
              );
            },
          ),
        );
      },
    );
  }

  String _getInitialRoute() {
    final authState = getIt<AuthCubit>().state;

    if (authState is AuthAuthenticated) {
      return Routes.mainScaffold;
    } else if (authState is AuthUnauthenticated) {
      return Routes.onBoardingScreen;
    }

    return Routes.onBoardingScreen;
  }
}
