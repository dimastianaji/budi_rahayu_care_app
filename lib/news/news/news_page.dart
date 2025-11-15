import 'package:flutter/material.dart';
import 'package:budi_rahayu_care_app/shared/widgets/header.dart';
import 'package:budi_rahayu_care_app/shared/widgets/bottom_nav.dart';
import 'news_detail_page.dart';

// MODEL SEDERHANA TANPA FIREBASE
class LocalNews {
  final String title;
  final String content;
  final String imageUrl;

  LocalNews({
    required this.title,
    required this.content,
    required this.imageUrl,
  });
}

// SIMULASI PENGAMBILAN DATA BERITA (PENGGANTI FIRESTORE)
Future<List<LocalNews>> fetchNews() async {
  await Future.delayed(const Duration(seconds: 1)); // simulasi loading

  return [
    LocalNews(
      title: "Pembangunan Klinik Baru Telah Dimulai",
      content: "Proyek pembangunan gedung klinik baru resmi dimulai hari ini...",
      imageUrl: "https://picsum.photos/400/300?random=1",
    ),
    LocalNews(
      title: "Program Bantuan Kesehatan 2025",
      content:
          "Pemerintah meluncurkan program bantuan kesehatan bagi masyarakat...",
      imageUrl: "https://picsum.photos/400/300?random=2",
    ),
    LocalNews(
      title: "Layanan Vaksinasi Gratis",
      content:
          "Layanan vaksinasi gratis kembali dibuka untuk umum minggu depan...",
      imageUrl: "https://picsum.photos/400/300?random=3",
    ),
  ];
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

              // DAFTAR BERITA (TANPA FIREBASE)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: FutureBuilder<List<LocalNews>>(
                  future: fetchNews(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
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

                    final newsList = snapshot.data!;

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: newsList.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        final news = newsList[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => NewsDetailPage(
                                  title: news.title,
                                  content: news.content,
                                  imageUrl: news.imageUrl,
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
                                ClipRRect(
                                  borderRadius:
                                      const BorderRadius.vertical(top: Radius.circular(12)),
                                  child: Image.network(
                                    news.imageUrl,
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
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
