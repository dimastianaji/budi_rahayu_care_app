// lib/main.dart
import 'package:flutter/material.dart';
import '/home/view/home_page.dart'; 
import 'news/news/news_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(), 
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/news': (context) => const NewsPage(),
      },
    );
  }  
}
