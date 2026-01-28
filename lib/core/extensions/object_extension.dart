import 'package:doc_doc/core/themes/custom_colors.dart';
import 'package:flutter/material.dart';

import '../error/models/app_error.dart';
import '../error/types/error_handler.dart';

extension ErrorHandlerExtension on Object {
  AppError toAppError() {
    return ErrorHandler.handle(this);
  }
}
extension CustomColorsExtension on ThemeData {
  CustomColors get customColors {
    if (brightness == Brightness.light) {
      return CustomColors.light();
    } else {
      return CustomColors.dark();
    }
  }
}
