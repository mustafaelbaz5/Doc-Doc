import 'package:doc_doc/core/models/specializations_response_body.dart';
import 'package:doc_doc/core/networking/api_end_points.dart';

import 'package:doc_doc/core/networking/api_service.dart';

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
