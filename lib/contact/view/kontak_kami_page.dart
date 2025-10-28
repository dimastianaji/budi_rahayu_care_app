// lib/features/kontak_kami/view/kontak_kami_page.dart
import 'package:flutter/material.dart';
import 'package:budi_rahayu_care_app/shared/widgets/header.dart';
import 'package:budi_rahayu_care_app/shared/widgets/footer.dart';
import 'package:budi_rahayu_care_app/shared/widgets/bottom_nav.dart';

class KontakKamiPage extends StatelessWidget {
  const KontakKamiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'Kontak Kami',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),

              // Informasi Kontak
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Gg. Teratai, Kober,\nKec. Purwokerto Barat,\nKabupaten Banyumas, Jawa Tengah 53132',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Instagram
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.email_outlined, color: Colors.grey),
                        const SizedBox(width: 8),
                        const Text(
                          '@budirahayual_barokah',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Telepon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.phone_outlined, color: Colors.grey),
                        const SizedBox(width: 8),
                        const Text(
                          '+62 812-3456-7890',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Tombol "Hubungi Kami" (WhatsApp)
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF000C8E),
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 6,
                  ),
                  onPressed: () {
                    // contoh: membuka WhatsApp
                    // bisa juga diarahkan ke halaman form kontak jika perlu
                  },
                  child: const Text(
                    'Hubungi Kami',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Gambar Peta Lokasi
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'lib/shared/assets/images/maps.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
                ),
              ),

              const SizedBox(height: 48),

            ],
          ),
        ),
      ),

      // Tambahkan Navbar di bagian bawah
      bottomNavigationBar: const BottomNav(currentIndex: 4),
    );
  }
}
