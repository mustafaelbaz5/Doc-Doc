import '../../../../../../core/data/models/doctor_data_model.dart';
import '../../../../../../core/networking/api_end_points.dart';
import '../../../../../../core/networking/api_service.dart';

class AllDoctorsRemoteApi {
  final ApiService apiService;

  AllDoctorsRemoteApi({required this.apiService});
  Future<List<DoctorDataModel>> getAllDoctors() async {
    final response = await apiService.get<Map<String, dynamic>>(
      endPoint: ApiEndPoints.allDoctorsEndPoint,
    );
    return (response['data'] as List)
        .map((final item) => DoctorDataModel.fromJson(item))
        .toList();
  }

  Future<DoctorDataModel> showDoctorDetails(final int doctorId) async {
    final response = await apiService.get<Map<String, dynamic>>(
      endPoint: '${ApiEndPoints.showDoctorDetailsEndPoint}$doctorId',
    );
    return DoctorDataModel.fromJson(response['data']);
  }

  Future<List<DoctorDataModel>> filterDoctors({
    final String? specializationId,
    final String? cityId,
    final String? appointPrice,
  }) async {
    final Map<String, dynamic> queryParameters = {};

    if (cityId != null && cityId.isNotEmpty) {
      queryParameters['city'] = cityId;
    }

    if (specializationId != null && specializationId.isNotEmpty) {
      queryParameters['specialization'] = specializationId;
    }

    if (appointPrice != null && appointPrice.isNotEmpty) {
      queryParameters['appoint_price'] = appointPrice;
    }

    final response = await apiService.get<Map<String, dynamic>>(
      endPoint: ApiEndPoints.filterDoctorsEndPoint,
      queryParameters: queryParameters,
    );

    return (response['data'] as List)
        .map((final item) => DoctorDataModel.fromJson(item))
        .toList();
  }

  Future<List<DoctorDataModel>> searchDoctors(final String name) async {
    final response = await apiService.get<Map<String, dynamic>>(
      endPoint: '${ApiEndPoints.searchDoctorsEndPoint}$name',
    );
    return (response['data'] as List)
        .map((final item) => DoctorDataModel.fromJson(item))
        .toList();
  }
}
