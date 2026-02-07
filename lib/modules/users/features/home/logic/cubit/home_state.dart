part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class SpecializationsLoading extends HomeState {}

final class SpecializationsSuccess extends HomeState {
  final List<SpecializationDataModel> specializations;
  final List<Doctor>? doctorsList;

  SpecializationsSuccess({required this.specializations, this.doctorsList});

  SpecializationsSuccess copyWith({
    final List<SpecializationDataModel>? specializations,
    final List<Doctor>? doctorsList,
  }) {
    return SpecializationsSuccess(
      specializations: specializations ?? this.specializations,
      doctorsList: doctorsList ?? this.doctorsList,
    );
  }
}

final class SpecializationsFailure extends HomeState {
  final AppError error;
  SpecializationsFailure({required this.error});
}
