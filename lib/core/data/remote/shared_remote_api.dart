import '../models/city_data_model.dart';
import '../models/specializations_response_body.dart';
import '../../networking/api_end_points.dart';
import '../../networking/api_service.dart';

class SharedRemoteApi {
  final ApiService apiService;
  SharedRemoteApi({required this.apiService});

  Future<SpecializationsResponseBody> getSpecializations() async {
    final data = await apiService.get<Map<String, dynamic>>(
      endPoint: ApiEndPoints.allSpecializationEndpoint,
    );
    return SpecializationsResponseBody.fromJson(data);
  }

  Future<List<CityDataModel>> getCities() async {
    final response = await apiService.get<Map<String, dynamic>>(
      endPoint: ApiEndPoints.citiesEndPoint,
    );
    return (response['data'] as List)
        .map((final item) => CityDataModel.fromJson(item))
        .toList();
  }
}
