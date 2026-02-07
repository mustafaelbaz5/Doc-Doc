import '../../../../../../core/error/types/error_handler.dart';
import '../../../../../../core/models/specializations_response_body.dart';
import '../remote/home_remote_api.dart';
import 'home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeRemoteApi homeRemoteApi;
  HomeRepoImpl({required this.homeRemoteApi});
  @override
  Future<SpecializationsResponseBody> getSpecialization() async {
    try {
      return await homeRemoteApi.getSpecialization();
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }
}
