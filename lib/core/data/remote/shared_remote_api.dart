import 'package:doc_doc/core/data/models/city_data_model.dart';
import 'package:doc_doc/core/data/models/specializations_response_body.dart';
import 'package:doc_doc/core/networking/api_end_points.dart';
import 'package:doc_doc/core/networking/api_service.dart';

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
