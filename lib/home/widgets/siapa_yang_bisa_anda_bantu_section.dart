import 'package:flutter/material.dart';

class SiapaYangBisaAndaBantuSection extends StatelessWidget {
  const SiapaYangBisaAndaBantuSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF000C8E), 
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Judul Section
          const Text(
            'Siapa yang Bisa Anda Bantu?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 16),

          // Deskripsi
          const Text(
            'Dengan mensponsori seorang anak, Anda mengubah hidup mereka dan memastikan masa depan yang lebih cerah. Dukungan Anda membantu Peduli Anak menyediakan pengasuhan, pendidikan, dan layanan kesehatan yang esensial. Kami bergantung pada para donor untuk mendukung lebih banyak anak, membimbing mereka menjadi dewasa mandiri dan memutus siklus kemiskinan.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 32),

          // Gambar Card (dua karakter)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCharacterCard(
                imageAsset: 'lib/shared/assets/images/kid1.png',
                name: 'Anak A',
              ),
              _buildCharacterCard(
                imageAsset: 'lib/shared/assets/images/kid2.png',
                name: 'Anak B',
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Indikator Page (dot indicator)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index == 0
                      ? Colors.white // aktif
                      : Colors.white30, // tidak aktif
                ),
              );
            }),
          ),

          const SizedBox(height: 24),

          // Tombol "Lihat Semua Anak"
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF000C8E),
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
              'Lihat Semua Anak',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget helper untuk card karakter
  Widget _buildCharacterCard({
    required String imageAsset,
    required String name,
  }) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            imageAsset,
            width: 120,
            height: 160,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}