import 'package:flutter/material.dart';
import 'widgets/header.dart';
import 'widgets/footer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Header(), // bagian atas
              Expanded(
                child: Center(
                  child: Text(
                    'Halaman Utama Yayasan',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              FooterSection(), // bagian bawah
            ],
          ),
        ),
      ),
    );
  }
}
