import '../../../../../../core/error/models/app_error.dart';
import '../../../../../../core/data/models/city_data_model.dart';
import '../../../../../../core/data/models/specialization_data_model.dart';
import '../../data/repo/all_doctors_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'filter_data_state.dart';

class FilterDataCubit extends Cubit<FilterDataState> {
  final AllDoctorsRepo allDoctorsRepo;

  FilterDataCubit({required this.allDoctorsRepo}) : super(FilterDataInitial());
  Future<void> loadFilterData() async {
    emit(FilterDataLoading());
    final specializations = await allDoctorsRepo.getSpecializations();
    final cities = await allDoctorsRepo.getCities();
    emit(
      FilterDataLoaded(specializations: specializations.data, cities: cities),
    );
  }
}
