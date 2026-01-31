class LoginResponseBody {
  final String message;
  final Data? data;
  final bool status;
  final int code;

  LoginResponseBody({
    required this.message,
    this.data,
    required this.status,
    required this.code,
  });

  factory LoginResponseBody.fromJson(final Map<String, dynamic> json) {
    return LoginResponseBody(
      message: json['message'] ?? '',
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      status: json['status'] ?? false,
      code: json['code'] ?? 0,
    );
  }
}

class Data {
  final String token;
  final String username;

  Data({required this.token, required this.username});

  factory Data.fromJson(final Map<String, dynamic> json) {
    return Data(token: json['token'] ?? '', username: json['username'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'token': token, 'username': username};
  }
}
