import 'package:doc_doc/core/error/types/error_handler.dart';
import 'package:doc_doc/modules/users/features/home/data/models/specializations_response_body.dart';
import 'package:doc_doc/modules/users/features/home/data/remote/home_remote_api.dart';
import 'package:doc_doc/modules/users/features/home/data/repo/home_repo.dart';

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
