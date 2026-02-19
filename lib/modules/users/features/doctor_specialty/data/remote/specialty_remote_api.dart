import '../../../../../../core/networking/api_service.dart';

import '../../../../../../core/models/specialization_data_model.dart';
import '../../../../../../core/models/specializations_response_body.dart';
import '../../../../../../core/networking/api_end_points.dart';

class SpecialtyRemoteApi {
  final ApiService apiService;

  SpecialtyRemoteApi({required this.apiService});

  Future<SpecializationsResponseBody> getAllSpecialization() async {
    final data = await apiService.get<Map<String, dynamic>>(
      endPoint: ApiEndPoints.allSpecializationEndpoint,
    );
    return SpecializationsResponseBody.fromJson(data);
  }

  Future<SpecializationDataModel> getSpecialtyById({
    required final int id,
  }) async {
    final data = await apiService.get<Map<String, dynamic>>(
      endPoint: '${ApiEndPoints.showSpecialtyEndpoint}$id',
    );
    return SpecializationDataModel.fromJson(data['data']);
  }
}
