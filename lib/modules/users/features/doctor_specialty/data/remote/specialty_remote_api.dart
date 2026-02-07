import 'package:dio/dio.dart';
import 'package:doc_doc/core/constants/api_constants.dart';
import 'package:doc_doc/core/models/specialization_data_model.dart';
import 'package:doc_doc/core/models/specializations_response_body.dart';

class SpecialtyRemoteApi {
  final Dio dio;
  final String _baseUrl = ApiConstants.apiBaseUrl;

  SpecialtyRemoteApi({required this.dio});

  Future<SpecializationsResponseBody> getAllSpecialization() async {
    final response = await dio.get(
      '$_baseUrl${ApiConstants.allSpecializationEndpoint}',
    );
    return SpecializationsResponseBody.fromJson(response.data);
  }

  Future<SpecializationDataModel> getSpecialtyById({
    required final int id,
  }) async {
    final response = await dio.get(
      '$_baseUrl${ApiConstants.showSpecialtyEndpoint}$id',
    );
    return SpecializationDataModel.fromJson(response.data['data']);
  }
}
