import 'package:flutter/material.dart';
import 'package:budi_rahayu_care_app/home/view/home_page.dart';
import 'package:budi_rahayu_care_app/about/view/tentang_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Budi Rahayu Care',
      initialRoute: '/', 
      routes: {
        '/': (context) => const HomePage(),
        '/about': (context) => const TentangPage(),
      },
    );
  }
}
