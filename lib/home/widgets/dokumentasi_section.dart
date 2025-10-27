// lib/features/home/widgets/dokumentasi_section.dart
import 'package:flutter/material.dart';

class DokumentasiSection extends StatelessWidget {
  const DokumentasiSection({super.key});

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
              'Dokumentasi',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Gambar Dokumentasi
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'lib/shared/assets/images/dokumentasi1.png', 
              width: double.infinity,
              height: 240,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}