import 'package:doc_doc/core/auth/data/models/sign_up_request_body.dart';
import 'package:doc_doc/core/auth/logic/cubit/auth_cubit.dart';
import 'package:doc_doc/core/auth/ui/widgets/password_validation.dart';
import 'package:doc_doc/core/extensions/context_extensions.dart';
import 'package:doc_doc/core/router/routes.dart';
import 'package:doc_doc/core/themes/app_text_styles.dart';
import 'package:doc_doc/core/ui/dialogs/app_dialogs.dart';
import 'package:doc_doc/core/ui/loaders/overlay_loader.dart';
import 'package:doc_doc/core/utils/regex.dart';
import 'package:doc_doc/core/utils/spacing.dart';
import 'package:doc_doc/core/utils/validators.dart';
import 'package:doc_doc/core/widgets/custom_dropdown_form_field.dart';
import 'package:doc_doc/core/widgets/custom_text_button.dart';
import 'package:doc_doc/core/widgets/custom_text_form_.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  late final TextEditingController _nameController = TextEditingController();
  late final TextEditingController _phoneController = TextEditingController();
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  late final TextEditingController _passwordConfirmationController =
      TextEditingController();

  // Password validation
  bool hasLowerCase = false;
  bool hasUpperCase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  // Gender
  String? _selectedGender;
  final Map<String, int> _genderMap = {'male': 0, 'female': 1};

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_updatePasswordValidation);
  }

  void _updatePasswordValidation() {
    final password = _passwordController.text;
    setState(() {
      hasLowerCase = AppRegex.hasLowerCase(password);
      hasUpperCase = AppRegex.hasUpperCase(password);
      hasSpecialCharacters = AppRegex.hasSpecialCharacter(password);
      hasNumber = AppRegex.hasNumber(password);
      hasMinLength = AppRegex.hasMinLength(password);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final body = SignUpRequestBody(
      name: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      passwordConfirmation: _passwordConfirmationController.text.trim(),
      gender: _genderMap[_selectedGender]!,
    );

    context.read<AuthCubit>().signUp(body);
  }

  Widget _buildTextField({
    required final String hint,
    required final TextEditingController controller,
    required final String? Function(String?) validator,
    final bool isPassword = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: responsiveHeight(18)),
      child: CustomTextFormField(
        controller: controller,
        hintText: hint,
        validator: validator,
        isPassword: isPassword,
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (final context, final state) {
        if (state is SignUpSuccess) {
          context.pushNamedAndRemoveAll(Routes.homeScreen);
        } else if (state is AuthFailure) {
          AppDialogs.showError(context, message: state.error.messageKey.tr());
        }
      },
      builder: (final context, final state) {
        return OverlayLoader(
          isLoading: state is AuthLoading,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField(
                  hint: 'auth.name'.tr(),
                  controller: _nameController,
                  validator: Validators.name,
                ),
                _buildTextField(
                  hint: 'auth.phone'.tr(),
                  controller: _phoneController,
                  validator: Validators.phoneNumber,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: responsiveHeight(18)),
                  child: CustomDropdownFormField<String>(
                    hintText: 'auth.gender'.tr(),
                    value: _selectedGender,
                    items: [
                      DropdownMenuItem(
                        value: 'male',
                        child: Text('auth.male'.tr()),
                      ),
                      DropdownMenuItem(
                        value: 'female',
                        child: Text('auth.female'.tr()),
                      ),
                    ],
                    onChanged: (final value) =>
                        setState(() => _selectedGender = value),
                    validator: (_) => _selectedGender == null
                        ? 'auth.validation.required'.tr()
                        : null,
                  ),
                ),
                _buildTextField(
                  hint: 'auth.email'.tr(),
                  controller: _emailController,
                  validator: Validators.email,
                ),
                _buildTextField(
                  hint: 'auth.password'.tr(),
                  controller: _passwordController,
                  validator: Validators.password,
                  isPassword: true,
                ),
                _buildTextField(
                  hint: 'auth.confirm_password'.tr(),
                  controller: _passwordConfirmationController,
                  validator: (final value) {
                    final passwordError = Validators.password(value);
                    if (passwordError != null) return passwordError;
                    if (value != _passwordController.text) {
                      return 'auth.validation_password_mismatch'.tr();
                    }
                    return null;
                  },
                  isPassword: true,
                ),
                PasswordValidation(
                  hasLowerCase: hasLowerCase,
                  hasUpperCase: hasUpperCase,
                  hasNumber: hasNumber,
                  hasSpecialCharacters: hasSpecialCharacters,
                  hasMinLength: hasMinLength,
                ),
                verticalSpacing(40),
                CustomTextButton(
                  borderRadius: responsiveRadius(16),
                  text: 'auth.sign_up'.tr(),
                  textStyle: AppTextStyles.font18SemiBold,
                  style: CustomButtonStyle.filled,
                  size: CustomButtonSize.large,
                  onPressed: _submitForm,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
