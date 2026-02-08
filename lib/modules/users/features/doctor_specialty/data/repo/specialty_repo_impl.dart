import '../../../../../../core/models/specialization_data_model.dart';
import '../../../../../../core/models/specializations_response_body.dart';
import '../remote/specialty_remote_api.dart';
import 'specialty_repo.dart';

class SpecialtyRepoImpl implements SpecialtyRepo {
  final SpecialtyRemoteApi specialtyRemoteApi;

  SpecialtyRepoImpl({required this.specialtyRemoteApi});
  @override
  Future<SpecializationsResponseBody> getAllSpecialization() async {
    return await specialtyRemoteApi.getAllSpecialization();
  }

  @override
  Future<SpecializationDataModel> getSpecialtyById({
    required final int id,
  }) async {
    return await specialtyRemoteApi.getSpecialtyById(id: id);
  }
}
