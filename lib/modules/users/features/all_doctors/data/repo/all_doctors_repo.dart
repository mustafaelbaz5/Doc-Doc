import '../../../../../../core/data/models/city_data_model.dart';
import '../../../../../../core/data/models/doctor_data_model.dart';
import '../../../../../../core/data/models/specializations_response_body.dart';

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
