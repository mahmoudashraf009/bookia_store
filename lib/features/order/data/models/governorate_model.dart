class GovernorateModel {
  final int id;
  final String name;

  GovernorateModel({
    required this.id,
    required this.name,
  });

  factory GovernorateModel.fromJson(Map<String, dynamic> json) {
    return GovernorateModel(
      id: json['id'] ?? 0,
      name: json['governorate_name_en'] ?? json['governorate_name_ar'] ?? json['name'] ?? json['governorate_name'] ?? '',
    );
  }
}
