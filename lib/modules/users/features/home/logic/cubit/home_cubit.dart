import '../../../../../../core/error/models/app_error.dart';
import '../../../../../../core/models/doctor_data_model.dart';
import '../../../../../../core/models/specialization_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.homeRepo}) : super(HomeInitial());

  final HomeRepo homeRepo;

  /// Load all specializations
  Future<void> getHomeSpecializations() async {
    if (isClosed) return;
    emit(SpecializationsLoading());

    try {
      final response = await homeRepo.getSpecialization();

      if (isClosed) return;
      emit(
        SpecializationsSuccess(
          specializations: response.data,
          doctorsList: response.data.first.doctors,
        ),
      );
    } catch (error) {
      if (isClosed) return;
      emit(
        SpecializationsFailure(
          error: error is AppError ? error : AppError.unknown(),
        ),
      );
    }
  }

  void getDoctorsBySpecialization({required final int specializationId}) {
    if (isClosed) return;

    final currentState = state;

    if (currentState is! SpecializationsSuccess) return;

    final specialization = currentState.specializations.firstWhere(
      (final item) => item.id == specializationId,
    );

    if (isClosed) return;
    emit(currentState.copyWith(doctorsList: specialization.doctors));
  }
}
