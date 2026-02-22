import 'package:dio/dio.dart';
import 'package:doc_doc/core/data/remote/shared_remote_api.dart';
import 'package:doc_doc/modules/users/features/all_doctors/data/remote/all_doctors_remote_api.dart';
import 'package:doc_doc/modules/users/features/all_doctors/data/repo/all_doctors_repo.dart';
import 'package:doc_doc/modules/users/features/all_doctors/data/repo/all_doctors_repo_impl.dart';
import 'package:doc_doc/modules/users/features/all_doctors/logic/cubit/all_doctors/all_doctors_cubit.dart';
import 'package:doc_doc/modules/users/features/all_doctors/logic/cubit/filter_data/filter_data_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../../modules/users/features/doctor_specialty/data/remote/specialty_remote_api.dart';
import '../../modules/users/features/doctor_specialty/data/repo/specialty_repo.dart';
import '../../modules/users/features/doctor_specialty/data/repo/specialty_repo_impl.dart';
import '../../modules/users/features/doctor_specialty/logic/cubit/specialty_cubit.dart';
import '../../modules/users/features/home/data/remote/home_remote_api.dart';
import '../../modules/users/features/home/data/repo/home_repo.dart';
import '../../modules/users/features/home/data/repo/home_repo_impl.dart';
import '../../modules/users/features/home/logic/cubit/home_cubit.dart';
import '../../modules/users/features/main_navigation/cubit/bottom_nav_cubit.dart';
import '../auth/data/remote/auth_remote_api.dart';
import '../auth/data/repo/auth_repo.dart';
import '../auth/data/repo/auth_repo_impl.dart';
import '../auth/logic/cubit/auth_cubit.dart';
import '../networking/api_service.dart';
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
  if (!getIt.isRegistered<ApiService>()) {
    getIt.registerLazySingleton<ApiService>(() => ApiService(dio: dio));
  }

  if (!getIt.isRegistered<SharedRemoteApi>()) {
    getIt.registerLazySingleton<SharedRemoteApi>(
      () => SharedRemoteApi(apiService: getIt<ApiService>()),
    );
  }

  if (!getIt.isRegistered<AuthRemoteApi>()) {
    getIt.registerLazySingleton<AuthRemoteApi>(
      () => AuthRemoteApi(apiService: getIt<ApiService>()),
    );
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
    getIt.registerLazySingleton<HomeRemoteApi>(
      () => HomeRemoteApi(apiService: getIt<ApiService>()),
    );
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

  // Specialty
  if (!getIt.isRegistered<SpecialtyRemoteApi>()) {
    getIt.registerLazySingleton<SpecialtyRemoteApi>(
      () => SpecialtyRemoteApi(apiService: getIt<ApiService>()),
    );
  }

  if (!getIt.isRegistered<SpecialtyRepo>()) {
    getIt.registerLazySingleton<SpecialtyRepo>(
      () => SpecialtyRepoImpl(
        specialtyRemoteApi: getIt<SpecialtyRemoteApi>(),
        sharedRemoteApi: getIt<SharedRemoteApi>(),
      ),
    );
  }

  if (!getIt.isRegistered<SpecialtyCubit>()) {
    getIt.registerFactory<SpecialtyCubit>(
      () => SpecialtyCubit(specialtyRepo: getIt<SpecialtyRepo>()),
    );
  }

  // All Doctors
  if (!getIt.isRegistered<AllDoctorsRemoteApi>()) {
    getIt.registerLazySingleton<AllDoctorsRemoteApi>(
      () => AllDoctorsRemoteApi(apiService: getIt<ApiService>()),
    );
  }

  if (!getIt.isRegistered<AllDoctorsRepo>()) {
    getIt.registerLazySingleton<AllDoctorsRepo>(
      () => AllDoctorsRepoImpl(
        allDoctorsRemoteApi: getIt<AllDoctorsRemoteApi>(),
        sharedRemoteApi: getIt<SharedRemoteApi>(),
      ),
    );
  }

  if (!getIt.isRegistered<AllDoctorsCubit>()) {
    getIt.registerFactory<AllDoctorsCubit>(
      () => AllDoctorsCubit(allDoctorsRepo: getIt<AllDoctorsRepo>()),
    );
  }

  if (!getIt.isRegistered<FilterDataCubit>()) {
    getIt.registerFactory<FilterDataCubit>(
      () => FilterDataCubit(allDoctorsRepo: getIt<AllDoctorsRepo>()),
    );
  }
}
