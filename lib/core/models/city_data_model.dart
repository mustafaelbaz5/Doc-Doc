import 'package:doc_doc/core/models/governrate_data_model.dart';

class CityDataModel {
  final int id;
  final String name;
  final GovernrateDataModel governrate;

  CityDataModel({
    required this.id,
    required this.name,
    required this.governrate,
  });

  factory CityDataModel.fromJson(final Map<String, dynamic> json) {
    return CityDataModel(
      id: json['id'] as int,
      name: json['name'] as String,
      governrate: GovernrateDataModel.fromJson(
        json['governrate'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'governrate': governrate.toJson()};
  }
}
