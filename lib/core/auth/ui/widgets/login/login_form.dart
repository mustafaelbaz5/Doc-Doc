import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../themes/app_text_styles.dart';
import '../../../../utils/spacing.dart';
import '../../../../utils/validators.dart';
import '../../../../widgets/custom_text_button.dart';
import '../../../../widgets/custom_text_form_.dart';
import '../../../data/models/login_request_body.dart';
import '../../../logic/cubit/auth_cubit.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final body = LoginRequestBody(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      context.read<AuthCubit>().login(body);
    }
  }

  @override
  Widget build(final BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _emailController,
            hintText: "auth.email".tr(),
            validator: Validators.email,
          ),
          verticalSpacing(16),
          CustomTextFormField(
            controller: _passwordController,
            hintText: "auth.password".tr(),
            isPassword: true,
            validator: (final value) {
              if (value == null || value.isEmpty) {
                return "auth.validation.required".tr();
              }
              return null;
            },
          ),
          verticalSpacing(32),
          CustomTextButton(
            borderRadius: responsiveRadius(16),
            text: "auth.login".tr(),
            textStyle: AppTextStyles.font18SemiBold,
            style: CustomButtonStyle.filled,
            size: CustomButtonSize.large,
            onPressed: _submitForm,
          ),
        ],
      ),
    );
  }
}
