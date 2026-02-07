import 'package:dio/dio.dart';
import 'package:doc_doc/modules/users/features/home/data/remote/home_remote_api.dart';
import 'package:doc_doc/modules/users/features/home/data/repo/home_repo.dart';
import 'package:doc_doc/modules/users/features/home/data/repo/home_repo_impl.dart';
import 'package:doc_doc/modules/users/features/home/logic/cubit/home_cubit.dart';
import '../../modules/users/features/main_navigation/cubit/bottom_nav_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../auth/data/remote/auth_remote_api.dart';
import '../auth/data/repo/auth_repo.dart';
import '../auth/data/repo/auth_repo_impl.dart';
import '../auth/logic/cubit/auth_cubit.dart';
import '../networking/dio_factory.dart';
import '../service/secure_storage.dart';

final GetIt getIt = GetIt.instance;

Future<void> setUpDependencies() async {
  final FlutterSecureStorage flutterSecureStorage =
      const FlutterSecureStorage();

  if (!getIt.isRegistered<SecureStorage>()) {
    getIt.registerLazySingleton<SecureStorage>(
      () => SecureStorage(flutterSecureStorage),
    );
  }

  final Dio dio = await DioFactory.getDio();
  // Auth DI
  if (!getIt.isRegistered<AuthRemoteApi>()) {
    getIt.registerLazySingleton<AuthRemoteApi>(() => AuthRemoteApi(dio: dio));
  }

  if (!getIt.isRegistered<AuthRepo>()) {
    getIt.registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(
        authRemoteApi: getIt<AuthRemoteApi>(),
        secureStorage: getIt<SecureStorage>(),
      ),
    );
  }

  if (!getIt.isRegistered<AuthCubit>()) {
    getIt.registerLazySingleton<AuthCubit>(
      () => AuthCubit(authRepo: getIt<AuthRepo>()),
    );
  }

  // Home DI
  if (!getIt.isRegistered<HomeRemoteApi>()) {
    getIt.registerLazySingleton<HomeRemoteApi>(() => HomeRemoteApi(dio: dio));
  }

  if (!getIt.isRegistered<HomeRepo>()) {
    getIt.registerLazySingleton<HomeRepo>(
      () => HomeRepoImpl(homeRemoteApi: getIt<HomeRemoteApi>()),
    );
  }

  if (!getIt.isRegistered<HomeCubit>()) {
    getIt.registerFactory<HomeCubit>(
      () => HomeCubit(homeRepo: getIt<HomeRepo>()),
    );
  }

  if (!getIt.isRegistered<BottomNavCubit>()) {
    getIt.registerFactory<BottomNavCubit>(() => BottomNavCubit());
  }
}
