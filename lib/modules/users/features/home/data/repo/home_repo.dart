import '../../../../../../core/models/specializations_response_body.dart';

abstract class HomeRepo {
  Future<SpecializationsResponseBody> getSpecialization();
}
