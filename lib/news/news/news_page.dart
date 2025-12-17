import 'package:flutter/material.dart';
import 'package:budi_rahayu_care_app/shared/widgets/header.dart';
import 'package:budi_rahayu_care_app/shared/widgets/bottom_nav.dart';
import 'package:budi_rahayu_care_app/core/services/news_service.dart'; // ✅ Service kamu
import 'news_detail_page.dart';

// MODEL BERITA (sesuaikan dengan struktur tabel Supabase)
class News {
  final String id;
  final String title;
  final String content;
  final String? imageUrl;
  final DateTime createdAt;

  News({
    required this.id,
    required this.title,
    required this.content,
    this.imageUrl,
    required this.createdAt,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      imageUrl: json['image_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}

// Ambil berita dari NewsService
Future<List<News>> _fetchNews() async {
  final List<Map<String, dynamic>> rawNews = await NewsService.getAllNews();
  return rawNews.map((json) => News.fromJson(json)).toList();
}

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Header(),

              // Judul Halaman
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                child: const Center(
                  child: Text(
                    'Berita Terbaru',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),

              // DAFTAR BERITA DARI SUPABASE
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: FutureBuilder<List<News>>(
                  future: _fetchNews(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Center(
                          child: Text(
                            'Gagal memuat berita: ${snapshot.error}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    }

                    final newsList = snapshot.data ?? [];

                    if (newsList.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Center(
                          child: Text(
                            'Belum ada berita.',
                            style: TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                        ),
                      );
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: newsList.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        final news = newsList[index];
                        final imageUrl = news.imageUrl?.trim();

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => NewsDetailPage(
                                  title: news.title,
                                  content: news.content,
                                  imageUrl: imageUrl,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 6,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Gambar berita
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                  child: imageUrl != null && imageUrl.isNotEmpty
                                      ? Image.network(
                                          imageUrl,
                                          height: 100,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              height: 100,
                                              color: Colors.grey[200],
                                              child: const Icon(Icons.image_not_supported, size: 24),
                                            );
                                          },
                                        )
                                      : Container(
                                          height: 100,
                                          color: Colors.grey[200],
                                          child: const Icon(Icons.article, size: 24),
                                        ),
                                ),

                                // Judul
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    news.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),

                                // Konten ringkas
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    news.content,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: 3,
        onItemTapped: (index) {},
      ),
    );
  }
}