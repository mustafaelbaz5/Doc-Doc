part of 'all_doctors_cubit.dart';

@immutable
sealed class AllDoctorsState {}

final class AllDoctorsInitial extends AllDoctorsState {}

final class AllDoctorsLoading extends AllDoctorsState {}

final class AllDoctorsLoaded extends AllDoctorsState {
  final List<DoctorDataModel> doctors;
  AllDoctorsLoaded({required this.doctors});
}

final class AllDoctorsError extends AllDoctorsState {
  final AppError error;
  AllDoctorsError({required this.error});
}
