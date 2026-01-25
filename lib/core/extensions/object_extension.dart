import '../error/models/app_error.dart';
import '../error/types/error_handler.dart';

extension ErrorHandlerExtension on Object {
  AppError toAppError() {
    return ErrorHandler.handle(this);
  }
}
