import 'package:doc_doc/core/auth/ui/widgets/password_validation.dart';
import 'package:doc_doc/core/utils/regex.dart';
import 'package:doc_doc/core/utils/spacing.dart';
import 'package:doc_doc/core/utils/validators.dart';
import 'package:doc_doc/core/widgets/custom_text_form_.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController = TextEditingController();
  late final TextEditingController _phoneController = TextEditingController();
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  late final TextEditingController _passwordConfirmationController =
      TextEditingController();

  bool hasLowerCase = false;
  bool hasUpperCase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;

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

  Widget _buildField({
    required final String hint,
    required final TextEditingController controller,
    required final String? Function(String?) validator,
    final bool isPassword = false,
  }) {
    return Column(
      children: [
        CustomTextFormField(
          controller: controller,
          hintText: hint,
          validator: validator,
          isPassword: isPassword,
        ),
        verticalSpacing(18),
      ],
    );
  }

  @override
  Widget build(final BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildField(
            hint: 'Name',
            controller: _nameController,
            validator: (final value) => (value == null || value.isEmpty)
                ? 'Please enter a valid name'
                : null,
          ),
          _buildField(
            hint: 'Phone',
            controller: _phoneController,
            validator: Validators.phoneNumber,
          ),
          _buildField(
            hint: 'Email',
            controller: _emailController,
            validator: Validators.email,
          ),
          _buildField(
            hint: 'Password',
            controller: _passwordController,
            validator: Validators.password,
            isPassword: true,
          ),
          _buildField(
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
        ],
      ),
    );
  }
}
