import 'package:doc_doc/core/data/models/doctor_data_model.dart';
import 'package:doc_doc/core/networking/api_end_points.dart';
import 'package:doc_doc/core/networking/api_service.dart';

class DoctorDetailsRemoteApi {
  final ApiService apiService;

  DoctorDetailsRemoteApi({required this.apiService});
  Future<DoctorDataModel> showDoctorDetails(final int doctorId) async {
    final response = await apiService.get<Map<String, dynamic>>(
      endPoint: '${ApiEndPoints.showDoctorDetailsEndPoint}$doctorId',
    );
    return DoctorDataModel.fromJson(response['data']);
  }
}
