import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D1B66), // warna biru tua
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Logo Yayasan
          Image.asset(
            'lib/shared/assets/images/logo.png',
            height: 50,
          ),
          const SizedBox(height: 24),

          // Menu Navigasi
          const Column(
            children: [
              Text('Tentang', style: TextStyle(color: Colors.white, fontSize: 14)),
              SizedBox(height: 8),
              Text('Donasi', style: TextStyle(color: Colors.white, fontSize: 14)),
              SizedBox(height: 8),
              Text('Berita', style: TextStyle(color: Colors.white, fontSize: 14)),
              SizedBox(height: 8),
              Text('Kontak Kami', style: TextStyle(color: Colors.white, fontSize: 14)),
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
                  // aksi ketika ikon Instagram ditekan
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
                  // aksi ketika ikon WhatsApp ditekan
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
}
