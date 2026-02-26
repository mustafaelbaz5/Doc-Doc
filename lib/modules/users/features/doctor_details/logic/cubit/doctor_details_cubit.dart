import 'package:doc_doc/core/data/models/doctor_data_model.dart';
import 'package:doc_doc/core/error/models/app_error.dart';
import 'package:doc_doc/modules/users/features/doctor_details/data/repo/doctor_details_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'doctor_details_state.dart';

class DoctorDetailsCubit extends Cubit<DoctorDetailsState> {
  DoctorDetailsCubit({required this.doctorDetailsRepo})
    : super(DoctorDetailsInitial());
  final DoctorDetailsRepo doctorDetailsRepo;

  Future<void> showDoctorDetails(final int doctorId) async {
    emit(DoctorDetailsLoading());
    try {
      final doctor = await doctorDetailsRepo.showDoctorDetails(doctorId);
      emit(DoctorDetailsSuccess(doctor: doctor));
    } catch (error) {
      emit(
        DoctorDetailsError(
          error: error is AppError ? error : AppError.unknown(),
        ),
      );
    }
  }
}
