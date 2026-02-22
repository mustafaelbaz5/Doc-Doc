import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/data/models/doctor_data_model.dart';
import '../../../../../../core/data/models/specialization_data_model.dart';
import '../../../../../../core/error/models/app_error.dart';
import '../../data/repo/specialty_repo.dart';

part 'specialty_state.dart';

class SpecialtyCubit extends Cubit<SpecialtyState> {
  SpecialtyCubit({required this.specialtyRepo}) : super(SpecialtyInitial());

  final SpecialtyRepo specialtyRepo;

  Future<void> getAllSpecializations() async {
    if (isClosed) return;
    emit(SpecialtyLoading());
    try {
      final response = await specialtyRepo.getAllSpecialization();
      if (isClosed) return;
      emit(AllSpecializationLoaded(specializations: response.data));
    } catch (error) {
      if (isClosed) return;
      emit(
        SpecialtyFailed(error: error is AppError ? error : AppError.unknown()),
      );
    }
  }

  Future<void> getSpecialtyById({required final int specialtyId}) async {
    if (isClosed) return;
    emit(SpecialtyLoading());
    try {
      final response = await specialtyRepo.getSpecialtyById(id: specialtyId);
      if (isClosed) return;
      emit(SpecialtyLoaded(doctorsList: response.doctors));
    } catch (error) {
      if (isClosed) return;
      emit(
        SpecialtyFailed(error: error is AppError ? error : AppError.unknown()),
      );
    }
  }
}
