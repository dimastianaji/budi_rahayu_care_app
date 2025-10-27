import 'package:flutter/material.dart';

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
      // Logo lengkap yayasan
      Image.asset(
        'lib/assets/images/logo.png',
        height: 45,
      ),

      // Tombol menu 3 garis
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
                _menuItem("Tentang"),
                _menuItem("Donasi"),
                _menuItem("Berita"),
                _menuItem("Kontak Kami"),
                _menuItem("Login"),
              ],
            ),
          ),
          crossFadeState:
              _isMenuOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        ),
      ],
    );
  }

  // Widget untuk tiap item menu
  Widget _menuItem(String title) {
    return InkWell(
      onTap: () {
        setState(() {
          _isMenuOpen = false;
        });
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
