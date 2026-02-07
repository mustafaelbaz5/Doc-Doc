import 'core/auth/logic/cubit/auth_cubit.dart';
import 'core/auth/ui/user_authenticated_check.dart';
import 'core/di/dependency_injection.dart';
import 'core/ui/dialogs/app_dialogs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/router/app_router.dart';
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
      builder: (_, final _) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ThemeCubit()),
            BlocProvider.value(value: getIt<AuthCubit>()),
          ],
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (final context, final mode) {
              FlutterNativeSplash.remove();
              return BlocListener<AuthCubit, AuthState>(
                listenWhen: (final prev, final curr) =>
                    curr is AuthSessionExpired,
                listener: (final context, final state) {
                  if (state is AuthSessionExpired) {
                    AppDialogs.showCustomDialog(
                      context,
                      title: 'session_expired'.tr(),
                      message: 'errors.session_expired'.tr(),
                      buttonText: 'ok'.tr(),
                      onPressed: () {
                        // Just logout → UI reacts automatically
                        context.read<AuthCubit>().logout();
                      },
                    );
                  }
                },
                child: MaterialApp(
                  key: ValueKey(context.locale),
                  debugShowCheckedModeBanner: false,
                  title: 'DocDoc',
                  home: const UserAuthenticatedCheck(),
                  onGenerateRoute: appRouter.generateRoute,
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
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
}
