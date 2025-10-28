// lib/features/berita/view/news_page.dart
import 'package:flutter/material.dart';
import 'package:budi_rahayu_care_app/shared/widgets/header.dart';
import 'package:budi_rahayu_care_app/shared/widgets/footer.dart';
import 'package:budi_rahayu_care_app/news/models/news_model.dart';
import 'package:budi_rahayu_care_app/news/widgets/news_card.dart';
import 'package:budi_rahayu_care_app/news/widgets/news_detail_view.dart';
import 'package:budi_rahayu_care_app/news/news_repository.dart';
import 'news_detail_page.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<NewsModel> newsList = NewsRepository.getAllNews();

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

              // Daftar Berita
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
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
                    return NewsCard(
                      news: news,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => NewsDetailPage(news: news)),
                        );
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 48),

              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}