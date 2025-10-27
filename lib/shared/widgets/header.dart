// lib/shared/widgets/header.dart
import 'package:flutter/material.dart';

// Hanya import halaman yang benar-benar ada
import 'package:budi_rahayu_care_app/home/view/home_page.dart';
import 'package:budi_rahayu_care_app/contact/view/kontak_kami_page.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Bagian header utama
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF002984), Color(0xFF3D5AFE)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo → kembali ke HomePage
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

              // Tombol menu
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _isMenuOpen = !_isMenuOpen;
                  });
                },
              ),
            ],
          ),
        ),

        // Dropdown menu
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
          firstChild: const SizedBox.shrink(),
          secondChild: Container(
            color: Colors.white,
            width: double.infinity,
            child: Column(
              children: [
                _menuItem("Tentang", () {}),
                _menuItem("Donasi", () {}),
                _menuItem("Berita", () {}),
                _menuItem("Kontak Kami", () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const KontakKamiPage()),
                  );
                }),
                _menuItem("Login", () {}),
              ],
            ),
          ),
          crossFadeState:
              _isMenuOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        ),
      ],
    );
  }

  Widget _menuItem(String title, VoidCallback onTap) {
    return InkWell(
      onTap: () {
        setState(() {
          _isMenuOpen = false;
        });
        onTap(); // Jika onTap kosong, tidak ada aksi
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black12),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}