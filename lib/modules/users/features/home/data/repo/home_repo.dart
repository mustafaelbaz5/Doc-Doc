import 'package:doc_doc/modules/users/features/home/data/models/specializations_response_body.dart';

abstract class HomeRepo {
  Future<SpecializationsResponseBody> getSpecialization();
}
