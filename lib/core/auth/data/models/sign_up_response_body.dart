class SignUpResponseBody {
  final String? message;
  final bool? status;
  final int? code;

  /// success data
  final UserData? userData;

  /// error data
  final Map<String, List<String>>? errors;

  SignUpResponseBody({
    this.message,
    this.status,
    this.code,
    this.userData,
    this.errors,
  });

  factory SignUpResponseBody.fromJson(final Map<String, dynamic> json) {
    return SignUpResponseBody(
      message: json['message'],
      status: json['status'],
      code: json['code'],
      userData: json['status'] == true && json['data'] != null
          ? UserData.fromJson(json['data'])
          : null,
      errors: json['status'] == false && json['data'] != null
          ? _parseErrors(json['data'])
          : null,
    );
  }

  static Map<String, List<String>> _parseErrors(
    final Map<String, dynamic> data,
  ) {
    final Map<String, List<String>> errors = {};
    data.forEach((final key, final value) {
      errors[key] = List<String>.from(value);
    });
    return errors;
  }
}

class UserData {
  final String? token;
  final String? userName;

  UserData({this.token, this.userName});

  factory UserData.fromJson(final Map<String, dynamic> json) {
    return UserData(token: json['token'], userName: json['username']);
  }
}
