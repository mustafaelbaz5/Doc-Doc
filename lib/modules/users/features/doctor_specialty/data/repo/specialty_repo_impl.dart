import 'package:doc_doc/core/error/types/error_handler.dart';
import 'package:doc_doc/core/models/specialization_data_model.dart';
import 'package:doc_doc/core/models/specializations_response_body.dart';
import 'package:doc_doc/modules/users/features/doctor_specialty/data/remote/specialty_remote_api.dart';
import 'package:doc_doc/modules/users/features/doctor_specialty/data/repo/specialty_repo.dart';

class SpecialtyRepoImpl implements SpecialtyRepo {
  final SpecialtyRemoteApi specialtyRemoteApi;

  SpecialtyRepoImpl({required this.specialtyRemoteApi});
  @override
  Future<SpecializationsResponseBody> getAllSpecialization() async {
    try {
      return await specialtyRemoteApi.getAllSpecialization();
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  @override
  Future<SpecializationDataModel> getSpecialtyById({
    required final int id,
  }) async {
    try {
      return await specialtyRemoteApi.getSpecialtyById(id: id);
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }
}
