// lib/features/home/widgets/berita_terbaru_section.dart
import 'package:flutter/material.dart';

class BeritaSection extends StatelessWidget {
  const BeritaSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Judul Section
          const Center(
            child: Text(
            'Berita Terbaru',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          ),

          const SizedBox(height: 16),

          // Daftar Artikel (Card)
          Column(
            children: [
              _buildArticleCard(
                imageAsset: 'lib/shared/assets/images/GambarBerita1.png',
                title: 'Judul Berita Pertama',
                description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              ),
              const SizedBox(height: 16),
              _buildArticleCard(
                imageAsset: 'lib/shared/assets/images/GambarBerita1.png',
                title: 'Judul Berita Kedua',
                description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Tombol "Tampilkan Semua"
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF000C8E), // biru tua
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 6,
              ),
              onPressed: () {
                // Aksi saat tombol ditekan
              },
              child: const Text(
                'Tampilkan Semua',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget helper untuk card artikel
  Widget _buildArticleCard({
    required String imageAsset,
    required String title,
    required String description,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              imageAsset,
              width: double.infinity,
              height: 160,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Baca selengkapnya',
                  style: const TextStyle(
                    color: Color(0xFF000C8E),
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}