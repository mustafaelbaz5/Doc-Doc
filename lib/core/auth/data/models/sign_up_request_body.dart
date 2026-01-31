class SignUpRequestBody {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String passwordConfirmation;
  final int gender;

  SignUpRequestBody({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.passwordConfirmation,
    required this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'gender': gender,
    };
  }
}
