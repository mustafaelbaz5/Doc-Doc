import 'package:doc_doc/core/data/models/doctor_data_model.dart';
import 'package:doc_doc/modules/users/features/doctor_details/data/remote/doctor_details_remote_api.dart';
import 'package:doc_doc/modules/users/features/doctor_details/data/repo/doctor_details_repo.dart';

class DoctorDetailsRepoImpls implements DoctorDetailsRepo {
  final DoctorDetailsRemoteApi doctorDetailsRemoteApi;

  DoctorDetailsRepoImpls({required this.doctorDetailsRemoteApi});

  @override
  Future<DoctorDataModel> showDoctorDetails(final int doctorId) async {
    return await doctorDetailsRemoteApi.showDoctorDetails(doctorId);
  }
}
