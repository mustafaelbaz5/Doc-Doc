import '../../../../../../core/data/models/specializations_response_body.dart';
import '../../../../../../core/networking/api_end_points.dart';

import '../../../../../../core/networking/api_service.dart';

class HomeRemoteApi {
  final ApiService apiService;

  HomeRemoteApi({required this.apiService});

  Future<SpecializationsResponseBody> getSpecialization() async {
    final data = await apiService.get<Map<String, dynamic>>(
      endPoint: ApiEndPoints.homeSpecializationEndPoint,
    );
    return SpecializationsResponseBody.fromJson(data);
  }
}
