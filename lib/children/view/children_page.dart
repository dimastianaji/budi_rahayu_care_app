import 'package:flutter/material.dart';
import 'package:budi_rahayu_care_app/shared/widgets/header.dart';
import 'package:budi_rahayu_care_app/children/widgets/child_card.dart';
import 'package:budi_rahayu_care_app/shared/widgets/bottom_nav.dart';

class ChildrenPage extends StatefulWidget {
  const ChildrenPage({super.key});

  @override
  State<ChildrenPage> createState() => _ChildrenPageState();
}

class _ChildrenPageState extends State<ChildrenPage> {
  bool _showAll = false; 

  // Data semua anak
  final List<Map<String, dynamic>> _allAnakList = [
    {
      'name': 'Zhafir Zaidan Awil',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'image': 'lib/shared/assets/images/kid1.png',
    },
    {
      'name': 'Dimastian Aji Wibowo',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'image': 'lib/shared/assets/images/kid2.png',
    },
    {
      'name': 'Dimas Abhipraya Ramanyah',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'image': 'lib/shared/assets/images/kid1.png',
    },
    {
      'name': 'Muhammad Shafiq Rusna',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'image': 'lib/shared/assets/images/kid2.png',
    },
    {
      'name': 'Alya Putri Ramadhani',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'image': 'lib/shared/assets/images/kid1.png',
    },
    {
      'name': 'Raka Pratama',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'image': 'lib/shared/assets/images/kid2.png',
    },
    {
      'name': 'Siti Nurhaliza',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'image': 'lib/shared/assets/images/kid1.png',
    },
    {
      'name': 'Budi Santoso',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'image': 'lib/shared/assets/images/kid2.png',
    },
    {
      'name': 'Nadia Wijaya',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'image': 'lib/shared/assets/images/kid1.png',
    },
    {
      'name': 'Kevin Hartanto',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'image': 'lib/shared/assets/images/kid2.png',
    },
    {
      'name': 'Putri Maharani',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'image': 'lib/shared/assets/images/kid1.png',
    },
    {
      'name': 'Aditya Firmansyah',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'image': 'lib/shared/assets/images/kid2.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> displayList = _showAll
        ? _allAnakList
        : _allAnakList.take(4).toList();

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
                    'Anak-anak di Yayasan Yatim Piatu Budi Rahayu Al Barokah',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),

              // Grid Daftar Anak — Pakai Wrap
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 16,     // jarak antar kolom
                  runSpacing: 16,  // jarak antar baris
                  children: displayList.map((anak) {
                    return SizedBox(
                      width: (MediaQuery.of(context).size.width - 48) / 2, // 2 kolom
                      child: ChildCard(
                        name: anak['name'],
                        description: anak['description'],
                        imageAsset: anak['image'],
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 24),

              // Tombol "Berikutnya" / "Tampilkan Lebih Sedikit"
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
                    setState(() {
                      _showAll = !_showAll;
                    });
                  },
                  child: Text(
                    _showAll ? 'Tampilkan Lebih Sedikit' : 'Berikutnya',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 48),

            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: 1,
        onItemTapped: (index) {},
      ),
    );
  }
}