import '../../../../../../core/data/models/specialization_data_model.dart';
import '../../../../../../core/data/models/specializations_response_body.dart';

abstract class SpecialtyRepo {
  Future<SpecializationsResponseBody> getAllSpecialization();
  Future<SpecializationDataModel> getSpecialtyById({required final int id});
}
