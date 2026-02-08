import 'package:dio/dio.dart';
import '../../../../../../core/constants/api_constants.dart';
import '../../../../../../core/models/specializations_response_body.dart';

class HomeRemoteApi {
  final Dio dio;
  final String _baseUrl = ApiConstants.apiBaseUrl;
  HomeRemoteApi({required this.dio});

  Future<SpecializationsResponseBody> getSpecialization() async {
    final response = await dio.get(
      "$_baseUrl${ApiConstants.homeSpecializationEndPoint}",
    );
    return SpecializationsResponseBody.fromJson(response.data);
  }
}
