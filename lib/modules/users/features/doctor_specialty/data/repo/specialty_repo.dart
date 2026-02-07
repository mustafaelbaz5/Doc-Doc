import '../../../../../../core/models/specialization_data_model.dart';
import '../../../../../../core/models/specializations_response_body.dart';

abstract class SpecialtyRepo {
  Future<SpecializationsResponseBody> getAllSpecialization();
  Future<SpecializationDataModel> getSpecialtyById({required final int id});
}
