import '../../../../../../core/models/specializations_response_body.dart';
import '../remote/home_remote_api.dart';
import 'home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeRemoteApi homeRemoteApi;
  HomeRepoImpl({required this.homeRemoteApi});
  @override
  Future<SpecializationsResponseBody> getSpecialization() async {
    return await homeRemoteApi.getSpecialization();
  }
}
