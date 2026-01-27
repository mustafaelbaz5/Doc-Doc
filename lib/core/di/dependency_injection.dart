import 'package:doc_doc/core/storage/secure_storage.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> setUpDependencies() async {
  // Secure Storage
if (!getIt.isRegistered<SecureStorage>()) {
    getIt.registerLazySingleton<SecureStorage>(() => SecureStorage());
  }
  // // Auth Dependencies Injection
  // getIt.registerLazySingleton<AuthService>(() => AuthService());
  // getIt.registerLazySingleton<AuthRepo>(
  //   () => AuthRepoImpl(
  //     authService: getIt<AuthService>(),
  //     secureStorage: getIt<SecureStorage>(),
  //   ),
  // );
  // getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthRepo>()));

  // // Courses Dependencies Injection
  // getIt.registerLazySingleton<CourseService>(() => CourseService());
  // getIt.registerLazySingleton<InstructorCoursesRepo>(
  //   () => InstructorCoursesRepoImpl(
  //     courseService: getIt<CourseService>(),
  //     authRepo: getIt<AuthRepo>(),
  //   ),
  // );
  // getIt.registerLazySingleton<InstructorCoursesCubit>(
  //   () => InstructorCoursesCubit(repo: getIt<InstructorCoursesRepo>()),
  // );
}
