class ChildModel {
  final String id;
  final String name;
  final String description;
  final String? photoUrl;
  final DateTime createdAt;

  ChildModel({
    required this.id,
    required this.name,
    required this.description,
    this.photoUrl,
    required this.createdAt,
  });

  factory ChildModel.fromJson(Map<String, dynamic> json) {
    return ChildModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      photoUrl: json['photo_url'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
