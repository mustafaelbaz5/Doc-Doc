class NestedSpecializationModel {
  final int id;
  final String name;

  NestedSpecializationModel({required this.id, required this.name});

  factory NestedSpecializationModel.fromJson(final Map<String, dynamic> json) {
    return NestedSpecializationModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
