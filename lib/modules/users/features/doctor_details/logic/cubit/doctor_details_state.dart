part of 'doctor_details_cubit.dart';

@immutable
sealed class DoctorDetailsState {}

final class DoctorDetailsInitial extends DoctorDetailsState {}
final class DoctorDetailsLoading extends DoctorDetailsState {}
final class DoctorDetailsSuccess extends DoctorDetailsState {
  final DoctorDataModel doctor;
  DoctorDetailsSuccess({required this.doctor});
}
final class DoctorDetailsError extends DoctorDetailsState {
  final AppError error;
  DoctorDetailsError({required this.error});
}

