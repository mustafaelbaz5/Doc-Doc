import 'package:doc_doc/core/models/city_data_model.dart';
import 'package:doc_doc/core/models/nested_specialization_model.dart';


class DoctorDataModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String photo;
  final String gender;
  final String address;
  final String description;
  final String degree;
  final NestedSpecializationModel specialization;
  final CityDataModel city;
  final int appointPrice;
  final String startTime;
  final String endTime;

  DoctorDataModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.photo,
    required this.gender,
    required this.address,
    required this.description,
    required this.degree,
    required this.specialization,
    required this.city,
    required this.appointPrice,
    required this.startTime,
    required this.endTime,
  });

  factory DoctorDataModel.fromJson(final Map<String, dynamic> json) {
    return DoctorDataModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      photo: json['photo'] as String,
      gender: json['gender'] as String,
      address: json['address'] as String,
      description: json['description'] as String,
      degree: json['degree'] as String,
      specialization: NestedSpecializationModel.fromJson(
        json['specialization'] as Map<String, dynamic>,
      ),
      city: CityDataModel.fromJson(json['city'] as Map<String, dynamic>),
      appointPrice: json['appoint_price'] as int,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'photo': photo,
      'gender': gender,
      'address': address,
      'description': description,
      'degree': degree,
      'specialization': specialization.toJson(),
      'city': city.toJson(),
      'appoint_price': appointPrice,
      'start_time': startTime,
      'end_time': endTime,
    };
  }
}
