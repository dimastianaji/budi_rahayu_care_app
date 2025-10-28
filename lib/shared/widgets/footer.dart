// lib/shared/widgets/footer.dart
import 'package:flutter/material.dart';
import 'package:budi_rahayu_care_app/home/view/home_page.dart';
import 'package:budi_rahayu_care_app/contact/view/kontak_kami_page.dart';
import 'package:budi_rahayu_care_app/about/view/tentang_page.dart';
import 'package:budi_rahayu_care_app/news/news/news_page.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D1B66), 
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Logo Yayasan → kembali ke HomePage
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
            child: Image.asset(
              'lib/shared/assets/images/logo.png',
              height: 45,
            ),
          ),
          const SizedBox(height: 24),

          Column(
            children: [
              _footerLink("Tentang", () {
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const TentangPage()),
              );
              }),
              const SizedBox(height: 8),
              _footerLink("Donasi", () {}),
              const SizedBox(height: 8),
              _footerLink("Berita", () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const NewsPage()),
                );
              }),
              const SizedBox(height: 8),
              _footerLink("Kontak Kami", () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const KontakKamiPage()),
                );
              }),
            ],
          ),
          const SizedBox(height: 24),

          // Alamat
          const Text(
            'Gg. Teratai, Kober, Kec. Purwokerto Barat,\nKabupaten Banyumas, Jawa Tengah 53132',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 24),

          // Kontak Sosial Media
          const Text(
            'Contact Us',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 12),

          // Ikon Sosial Media
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                },
                child: Image.asset(
                  'lib/shared/assets/icons/instagram.png',
                  height: 24,
                  width: 24,
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                },
                child: Image.asset(
                  'lib/shared/assets/icons/whatsapp.png',
                  height: 24,
                  width: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget helper untuk link footer
  Widget _footerLink(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
}