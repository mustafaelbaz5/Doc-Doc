import 'doctor_data_model.dart';

class SpecializationDataModel {
  final int id;
  final String name;
  final List<DoctorDataModel> doctors;

  SpecializationDataModel({
    required this.id,
    required this.name,
    required this.doctors,
  });

  factory SpecializationDataModel.fromJson(final Map<String, dynamic> json) {
    return SpecializationDataModel(
      id: json['id'] as int,
      name: json['name'] as String,
      doctors: (json['doctors'] as List<dynamic>)
          .map(
            (final item) =>
                DoctorDataModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'doctors': doctors.map((final doc) => doc.toJson()).toList(),
    };
  }
}
