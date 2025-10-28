import 'package:flutter/material.dart';
import 'package:budi_rahayu_care_app/shared/widgets/bottom_nav.dart';
import 'package:budi_rahayu_care_app/shared/widgets/header.dart';
import 'package:budi_rahayu_care_app/home/widgets/hero_section.dart';
import 'package:budi_rahayu_care_app/home/widgets/donasi_section.dart';
import 'package:budi_rahayu_care_app/home/widgets/tujuan_section.dart';
import 'package:budi_rahayu_care_app/home/widgets/anak_section.dart';
import 'package:budi_rahayu_care_app/home/widgets/berita_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Header(),        
            HeroSection(),
            DonasiSection(),
            TujuanSection(),
            AnakSection(),
            BeritaSection(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: 0,
        onItemTapped: (index) {},
      ),
    );
  }
}
