import 'package:cloud_firestore/cloud_firestore.dart';

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

  factory NewsModel.fromFirestore(Map<String, dynamic> data) {
    Timestamp timestamp = data['date'] ?? Timestamp.now(); // Default jika null
    DateTime date = timestamp.toDate();
    
    return NewsModel(
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      date: date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'date': Timestamp.fromDate(date), // Simpan kembali sebagai Timestamp
    };
  }
}