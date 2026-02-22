part of 'filter_data_cubit.dart';

@immutable
sealed class FilterDataState {}

final class FilterDataInitial extends FilterDataState {}

final class FilterDataLoading extends FilterDataState {}

final class FilterDataLoaded extends FilterDataState {
  final List<SpecializationDataModel> specializations;
  final List<CityDataModel> cities;

  FilterDataLoaded({required this.specializations, required this.cities});
}

final class FilterDataError extends FilterDataState {
  final AppError error;
  FilterDataError({required this.error});
}
