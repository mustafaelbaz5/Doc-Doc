import '../../../../../../core/networking/api_service.dart';

import '../../../../../../core/models/specialization_data_model.dart';
import '../../../../../../core/networking/api_end_points.dart';

class SpecialtyRemoteApi {
  final ApiService apiService;

  SpecialtyRemoteApi({required this.apiService});

  Future<SpecializationDataModel> getSpecialtyById({
    required final int id,
  }) async {
    final data = await apiService.get<Map<String, dynamic>>(
      endPoint: '${ApiEndPoints.showSpecialtyEndpoint}$id',
    );
    return SpecializationDataModel.fromJson(data['data']);
  }
}
