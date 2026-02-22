import 'package:doc_doc/core/error/models/app_error.dart';
import 'package:doc_doc/core/models/doctor_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/all_doctors_repo.dart';

part 'all_doctors_state.dart';

class AllDoctorsCubit extends Cubit<AllDoctorsState> {
  final AllDoctorsRepo allDoctorsRepo;

  AllDoctorsCubit({required this.allDoctorsRepo}) : super(AllDoctorsInitial());

  List<DoctorDataModel> _allDoctors = [];

  Future<void> getAllDoctors() async {
    emit(AllDoctorsLoading());
    try {
      final response = await allDoctorsRepo.getAllDoctors();
      _allDoctors = response;
      emit(AllDoctorsLoaded(doctors: _allDoctors));
    } catch (error) {
      emit(
        AllDoctorsError(error: error is AppError ? error : AppError.unknown()),
      );
    }
  }

  Future<void> filterDoctors({
    final String? specializationId,
    final String? cityId,
  }) async {
    emit(AllDoctorsLoading());
    try {
      final response = await allDoctorsRepo.filterDoctors(
        specializationId: specializationId,
        cityId: cityId,
      );
      _allDoctors = response;
      emit(AllDoctorsLoaded(doctors: _allDoctors));
    } catch (error) {
      emit(
        AllDoctorsError(error: error is AppError ? error : AppError.unknown()),
      );
    }
  }

  Future<void> searchDoctors(final String name) async {
    emit(AllDoctorsLoading());
    try {
      final response = await allDoctorsRepo.searchDoctors(name);
      _allDoctors = response;
      emit(AllDoctorsLoaded(doctors: _allDoctors));
    } catch (error) {
      emit(
        AllDoctorsError(error: error is AppError ? error : AppError.unknown()),
      );
    }
  }

  void filterByPrice(final String? priceRange) {
    if (priceRange == null) {
      emit(AllDoctorsLoaded(doctors: _allDoctors));
      return;
    }
    final filtered = _allDoctors.where((final doctor) {
      final price = doctor.appointPrice;
      switch (priceRange) {
        case '< 100':
          return price < 100;
        case '100 - 200':
          return price >= 100 && price <= 200;
        case '200 - 300':
          return price >= 200 && price <= 300;
        case '> 300':
          return price > 300;
        default:
          return true;
      }
    }).toList();
    emit(AllDoctorsLoaded(doctors: filtered));
  }
}
