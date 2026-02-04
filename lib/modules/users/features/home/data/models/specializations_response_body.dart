
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

class SpecializationDataModel {
  final int id;
  final String name;
  final List<Doctor> doctors;

  SpecializationDataModel({required this.id, required this.name, required this.doctors});

  factory SpecializationDataModel.fromJson(final Map<String, dynamic> json) {
    return SpecializationDataModel(
      id: json['id'] as int,
      name: json['name'] as String,
      doctors: (json['doctors'] as List<dynamic>)
          .map((final item) => Doctor.fromJson(item as Map<String, dynamic>))
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

class Doctor {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String photo;
  final String gender;
  final String address;
  final String description;
  final String degree;
  final SpecializationMini specialization;
  final City city;
  final int appointPrice;
  final String startTime;
  final String endTime;

  Doctor({
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

  factory Doctor.fromJson(final Map<String, dynamic> json) {
    return Doctor(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      photo: json['photo'] as String,
      gender: json['gender'] as String,
      address: json['address'] as String,
      description: json['description'] as String,
      degree: json['degree'] as String,
      specialization: SpecializationMini.fromJson(
        json['specialization'] as Map<String, dynamic>,
      ),
      city: City.fromJson(json['city'] as Map<String, dynamic>),
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

class SpecializationMini {
  final int id;
  final String name;

  SpecializationMini({required this.id, required this.name});

  factory SpecializationMini.fromJson(final Map<String, dynamic> json) {
    return SpecializationMini(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

class City {
  final int id;
  final String name;
  final Governrate governrate;

  City({required this.id, required this.name, required this.governrate});

  factory City.fromJson(final Map<String, dynamic> json) {
    return City(
      id: json['id'] as int,
      name: json['name'] as String,
      governrate: Governrate.fromJson(
        json['governrate'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'governrate': governrate.toJson()};
  }
}

class Governrate {
  final int id;
  final String name;

  Governrate({required this.id, required this.name});

  factory Governrate.fromJson(final Map<String, dynamic> json) {
    return Governrate(id: json['id'] as int, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
