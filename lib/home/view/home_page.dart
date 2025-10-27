// lib/features/home/view/home_page.dart
import 'package:flutter/material.dart';
import 'package:budi_rahayu_care_app/shared/widgets/header.dart';
import 'package:budi_rahayu_care_app/shared/widgets/footer.dart';
import 'package:budi_rahayu_care_app/home/widgets/hero_section.dart';
import 'package:budi_rahayu_care_app/home/widgets/tujuan_kami_section.dart'; 

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Header(),
              HeroSection(),
              TujuanKamiSection(), 
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}