import 'package:doc_doc/core/data/remote/shared_remote_api.dart';

import '../../../../../../core/models/specialization_data_model.dart';
import '../../../../../../core/models/specializations_response_body.dart';
import '../remote/specialty_remote_api.dart';
import 'specialty_repo.dart';

class SpecialtyRepoImpl implements SpecialtyRepo {
  final SpecialtyRemoteApi specialtyRemoteApi;
  final SharedRemoteApi sharedRemoteApi;

  SpecialtyRepoImpl({
    required this.specialtyRemoteApi,
    required this.sharedRemoteApi,
  });
  @override
  Future<SpecializationsResponseBody> getAllSpecialization() async {
    return await sharedRemoteApi.getSpecializations();
  }

  @override
  Future<SpecializationDataModel> getSpecialtyById({
    required final int id,
  }) async {
    return await specialtyRemoteApi.getSpecialtyById(id: id);
  }
}
