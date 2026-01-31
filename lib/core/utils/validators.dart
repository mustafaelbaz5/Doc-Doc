import 'package:easy_localization/easy_localization.dart';

import '../utils/regex.dart';

class Validators {
  /// Validate email format
  static String? email(final String? value) {
    if (value == null || value.isEmpty || !AppRegex.isEmailValid(value)) {
      return 'auth.invalid_email'.tr();
    }
    return null;
  }

  /// Validate password with multiple rules
  static String? password(final String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (!AppRegex.hasLowerCase(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!AppRegex.hasUpperCase(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!AppRegex.hasNumber(value)) {
      return 'Password must contain at least one number';
    }

    if (!AppRegex.hasSpecialCharacter(value)) {
      return 'Password must contain at least one special character';
    }

    if (!AppRegex.hasMinLength(value)) {
      return 'Password must be at least 8 characters';
    }

    return null; // Password is valid
  }
}
