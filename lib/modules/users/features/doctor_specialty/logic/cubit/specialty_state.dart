part of 'specialty_cubit.dart';

@immutable
sealed class SpecialtyState {}

final class SpecialtyInitial extends SpecialtyState {}

final class SpecialtyLoading extends SpecialtyState {}

final class AllSpecializationLoaded extends SpecialtyState {
  final List<SpecializationDataModel>? specializations;
  AllSpecializationLoaded({required this.specializations});
}

final class SpecialtyLoaded extends SpecialtyState {
  final List<DoctorDataModel>? doctorsList;
  SpecialtyLoaded({required this.doctorsList});
}

final class SpecialtyFailed extends SpecialtyState {
  final AppError error;

  SpecialtyFailed({required this.error});
}
