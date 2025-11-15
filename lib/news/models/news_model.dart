class NewsModel {
  final String title;
  final String content;
  final String imageUrl;
  final DateTime date;

  NewsModel({
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.date,
  });

  factory NewsModel.fromMap(Map<String, dynamic> data) {
    return NewsModel(
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      date: DateTime.parse(data['date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'date': date.toIso8601String(),
    };
  }
}
