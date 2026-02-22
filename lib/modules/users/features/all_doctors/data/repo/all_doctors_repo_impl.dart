import 'package:doc_doc/core/data/remote/shared_remote_api.dart';
import 'package:doc_doc/core/data/models/city_data_model.dart';
import 'package:doc_doc/core/data/models/doctor_data_model.dart';
import 'package:doc_doc/core/data/models/specializations_response_body.dart';
import 'package:doc_doc/modules/users/features/all_doctors/data/remote/all_doctors_remote_api.dart';
import 'package:doc_doc/modules/users/features/all_doctors/data/repo/all_doctors_repo.dart';

class AllDoctorsRepoImpl implements AllDoctorsRepo {
  final AllDoctorsRemoteApi allDoctorsRemoteApi;
  final SharedRemoteApi sharedRemoteApi;
  AllDoctorsRepoImpl({
    required this.allDoctorsRemoteApi,
    required this.sharedRemoteApi,
  });
  @override
  Future<List<DoctorDataModel>> getAllDoctors() async {
    return await allDoctorsRemoteApi.getAllDoctors();
  }

  @override
  Future<List<DoctorDataModel>> filterDoctors({
    final String? specializationId,
    final String? cityId,
    final String? appointPrice,
  }) {
    return allDoctorsRemoteApi.filterDoctors(
      specializationId: specializationId,
      cityId: cityId,
      appointPrice: appointPrice,
    );
  }

  @override
  Future<List<DoctorDataModel>> searchDoctors(final String name) {
    return allDoctorsRemoteApi.searchDoctors(name);
  }

  @override
  Future<DoctorDataModel> showDoctorDetails(final int doctorId) {
    return allDoctorsRemoteApi.showDoctorDetails(doctorId);
  }

  @override
  Future<SpecializationsResponseBody> getSpecializations() {
    return sharedRemoteApi.getSpecializations();
  }

  @override
  Future<List<CityDataModel>> getCities() {
    return sharedRemoteApi.getCities();
  }
}
