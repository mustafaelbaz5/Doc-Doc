import '../../../../../../core/error/types/error_handler.dart';
import '../../../../../../core/models/specialization_data_model.dart';
import '../../../../../../core/models/specializations_response_body.dart';
import '../remote/specialty_remote_api.dart';
import 'specialty_repo.dart';

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
