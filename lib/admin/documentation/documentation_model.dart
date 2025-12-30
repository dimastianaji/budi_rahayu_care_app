class Documentation {
  final String id;
  final String title;
  final String? imageUrl;
  final DateTime createdAt;

  Documentation({
    required this.id,
    required this.title,
    this.imageUrl,
    required this.createdAt,
  });

  factory Documentation.fromMap(Map<String, dynamic> map) {
    return Documentation(
      id: map['id'],
      title: map['title'],
      imageUrl: map['image_url'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}
