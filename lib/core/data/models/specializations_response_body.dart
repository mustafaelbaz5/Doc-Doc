import 'specialization_data_model.dart';

class SpecializationsResponseBody {
  final bool status;
  final int code;
  final List<SpecializationDataModel> data;

  SpecializationsResponseBody({
    required this.status,
    required this.code,
    required this.data,
  });

  factory SpecializationsResponseBody.fromJson(
    final Map<String, dynamic> json,
  ) {
    return SpecializationsResponseBody(
      status: json['status'] as bool,
      code: json['code'] as int,
      data: (json['data'] as List<dynamic>)
          .map(
            (final item) =>
                SpecializationDataModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'code': code,
      'data': data.map((final spec) => spec.toJson()).toList(),
    };
  }
}
