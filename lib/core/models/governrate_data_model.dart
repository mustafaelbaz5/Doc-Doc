class GovernrateDataModel {
  final int id;
  final String name;

  GovernrateDataModel({required this.id, required this.name});

  factory GovernrateDataModel.fromJson(final Map<String, dynamic> json) {
    return GovernrateDataModel(id: json['id'] as int, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
