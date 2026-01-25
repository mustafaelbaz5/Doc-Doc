import 'package:flutter/material.dart';

import 'app_font_weight.dart';

class AppTextStyles {
  const AppTextStyles._();
  static const TextStyle font32Bold = TextStyle(
    fontSize: 32,
    fontWeight: AppFontWeight.bold,
  );
  static const TextStyle font16Regular = TextStyle(
    fontSize: 16,
    fontWeight: AppFontWeight.regular,
  );
}
