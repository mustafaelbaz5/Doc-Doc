import 'package:doc_doc/core/auth/data/models/sign_up_request_body.dart';
import 'package:doc_doc/core/auth/logic/cubit/auth_cubit.dart';
import 'package:doc_doc/core/auth/ui/widgets/password_validation.dart';
import 'package:doc_doc/core/extensions/context_extensions.dart';
import 'package:doc_doc/core/router/routes.dart';
import 'package:doc_doc/core/themes/app_text_styles.dart';
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
  final ScrollController _scrollController = ScrollController();

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
    _scrollController.dispose();
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

  // Reusable field builder
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
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (final context, final state) {
        final isLoading = state is AuthLoading;

        return SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField(
                  hint: 'Name',
                  controller: _nameController,
                  validator: (final value) => (value == null || value.isEmpty)
                      ? 'Please enter a valid name'
                      : null,
                ),
                _buildTextField(
                  hint: 'Phone',
                  controller: _phoneController,
                  validator: Validators.phoneNumber,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: responsiveHeight(18)),
                  child: CustomDropdownFormField<String>(
                    hintText: 'Gender',
                    value: _selectedGender,
                    items: const [
                      DropdownMenuItem(value: 'male', child: Text('Male')),
                      DropdownMenuItem(value: 'female', child: Text('Female')),
                    ],
                    onChanged: (final value) =>
                        setState(() => _selectedGender = value),
                    validator: (_) =>
                        _selectedGender == null ? 'Please select gender' : null,
                  ),
                ),
                _buildTextField(
                  hint: 'Email',
                  controller: _emailController,
                  validator: Validators.email,
                ),
                _buildTextField(
                  hint: 'Password',
                  controller: _passwordController,
                  validator: Validators.password,
                  isPassword: true,
                ),
                _buildTextField(
                  hint: 'Confirm Password',
                  controller: _passwordConfirmationController,
                  validator: (final value) {
                    final passwordError = Validators.password(value);
                    if (passwordError != null) return passwordError;
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
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
                  onPressed: isLoading ? null : _submitForm,
                  isLoading: isLoading,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
