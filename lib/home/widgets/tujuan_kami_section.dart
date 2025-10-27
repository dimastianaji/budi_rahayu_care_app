// lib/features/home/widgets/tujuan_kami_section.dart
import 'package:flutter/material.dart';

class TujuanKamiSection extends StatelessWidget {
  const TujuanKamiSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF9F8F4), // warna latar krem muda (sama dengan HeroSection)
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Judul Section
          const Text(
            'Tujuan Kami',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 16),

          // Deskripsi
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 32),

          // Tombol "Donasi"
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF000C8E), // biru tua
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 6,
            ),
            onPressed: () {
              // Aksi saat tombol Donasi ditekan
            },
            child: const Text(
              'Donasi',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Tombol "Tentang Kami" (Outline)
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF000C8E), // teks biru
              side: const BorderSide(color: Color(0xFF000C8E), width: 2),
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              // Aksi saat tombol Tentang Kami ditekan
            },
            child: const Text(
              'Tentang Kami',
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
}