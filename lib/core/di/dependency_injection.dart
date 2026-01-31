import 'package:dio/dio.dart';
import 'package:doc_doc/core/auth/data/apis/auth_service.dart';
import 'package:doc_doc/core/auth/data/repo/auth_repo.dart';
import 'package:doc_doc/core/auth/data/repo/auth_repo_impl.dart';
import 'package:doc_doc/core/auth/logic/cubit/auth_cubit.dart';
import 'package:doc_doc/core/networking/dio_factory.dart';
import 'package:doc_doc/core/service/secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

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

  if (!getIt.isRegistered<AuthService>()) {
    getIt.registerLazySingleton<AuthService>(() => AuthService(dio: dio));
  }

  if (!getIt.isRegistered<AuthRepo>()) {
    getIt.registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(authService: getIt<AuthService>()),
    );
  }

if (!getIt.isRegistered<AuthCubit>()) {
    getIt.registerFactory<AuthCubit>(
      () => AuthCubit(authRepo: getIt<AuthRepo>()),
    );
  }
}
