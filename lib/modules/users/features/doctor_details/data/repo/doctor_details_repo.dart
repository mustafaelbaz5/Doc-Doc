import 'package:doc_doc/core/data/models/doctor_data_model.dart';

abstract class DoctorDetailsRepo {
  Future<DoctorDataModel> showDoctorDetails(final int doctorId);
}
