import 'package:doc_doc/core/models/city_data_model.dart';
import 'package:doc_doc/core/models/doctor_data_model.dart';
import 'package:doc_doc/core/models/specializations_response_body.dart';

abstract class AllDoctorsRepo {
  Future<List<DoctorDataModel>> getAllDoctors();
  Future<DoctorDataModel> showDoctorDetails(final int doctorId);
  Future<List<DoctorDataModel>> filterDoctors({
    final String? specializationId,
    final String? cityId,
    final String? appointPrice,
  });
  Future<List<DoctorDataModel>> searchDoctors(final String name);
  Future<SpecializationsResponseBody> getSpecializations();
  Future<List<CityDataModel>> getCities();
}