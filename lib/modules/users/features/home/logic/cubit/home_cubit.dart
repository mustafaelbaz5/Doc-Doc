import 'package:doc_doc/core/error/models/app_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/specializations_response_body.dart';
import '../../data/repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.homeRepo}) : super(HomeInitial());

  final HomeRepo homeRepo;

  /// Load all specializations
Future<void> getAllSpecializations() async {
    emit(SpecializationsLoading());

    try {
      final response = await homeRepo.getSpecialization();
      emit(
        SpecializationsSuccess(
          specializations: response.data,
          doctorsList: response.data.first.doctors,
        ),
      );
    } catch (error) {
      emit(
        SpecializationsFailure(
          error: error is AppError ? error : AppError.unknown(),
        ),
      );
    }
  }

  void getDoctorsBySpecialization({required final int specializationId}) {
    final currentState = state;

    if (currentState is! SpecializationsSuccess) return;

    final specialization = currentState.specializations.firstWhere(
      (final item) => item.id == specializationId,
    );

    emit(currentState.copyWith(doctorsList: specialization.doctors));
  }
}
