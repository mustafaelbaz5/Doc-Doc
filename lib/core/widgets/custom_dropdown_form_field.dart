import '../extensions/context_extensions.dart';
import '../themes/app_colors.dart';
import '../themes/app_text_styles.dart';
import '../utils/spacing.dart';
import 'custom_text_form_.dart';
import 'package:flutter/material.dart';

class CustomDropdownFormField<T> extends StatelessWidget {
  const CustomDropdownFormField({
    super.key,
    required this.hintText,
    required this.items,
    this.value,
    this.onChanged,
    this.validator,
    this.style = CustomTextFieldStyle.filled,
    this.backgroundColor,
    this.borderColor,
    this.focusedBorderColor,
    this.contentPadding,
    this.borderRadius,
    this.enabled = true,
  });

  final String hintText;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? Function(T?)? validator;

  final CustomTextFieldStyle style;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final EdgeInsetsGeometry? contentPadding;
  final double? borderRadius;
  final bool enabled;

  OutlineInputBorder _buildBorder(
    final Color color, {
    final double width = 1.0,
    final double radius = 16,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(final BuildContext context) {
    final colors = context.customColors;

    final resolvedBackground =
        backgroundColor ??
        (style == CustomTextFieldStyle.outlined
            ? Colors.transparent
            : style == CustomTextFieldStyle.soft
            ? colors.accentBlueSoft.withValues(alpha: 0.3)
            : colors.surfaceVariant.withValues(alpha: 0.35));

    final defaultBorderColor = borderColor ?? colors.border;
    final focusBorderColor = focusedBorderColor ?? colors.accentBlue;
    final radius = borderRadius ?? responsiveRadius(16);

    return DropdownButtonFormField<T>(
      initialValue: value,
      items: items,
      onChanged: enabled ? onChanged : null,
      validator: validator,
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: colors.textSecondary,
      ),
      style: AppTextStyles.font16Regular.copyWith(color: colors.textPrimary),
      decoration: InputDecoration(
        isDense: true,
        filled: style != CustomTextFieldStyle.outlined,
        fillColor: resolvedBackground,
        hintText: hintText,
        hintStyle: AppTextStyles.font16Regular.copyWith(
          color: colors.textSecondary.withValues(alpha: 0.6),
        ),
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(
              horizontal: responsiveWidth(20),
              vertical: responsiveHeight(18),
            ),
        enabledBorder: _buildBorder(
          defaultBorderColor.withValues(alpha: 0.6),
          width: responsiveRadius(0.8),
          radius: radius,
        ),
        focusedBorder: _buildBorder(
          focusBorderColor,
          width: responsiveRadius(1.5),
          radius: radius,
        ),
        errorBorder: _buildBorder(
          AppColors.red100,
          width: responsiveRadius(1.4),
          radius: radius,
        ),
        focusedErrorBorder: _buildBorder(
          AppColors.red100,
          width: responsiveRadius(1.6),
          radius: radius,
        ),
      ),
    );
  }
}
