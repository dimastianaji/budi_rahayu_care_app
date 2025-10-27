import 'package:flutter/material.dart';

class SectionTujuan extends StatelessWidget {
  const SectionTujuan({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Image.asset("assets/images/foto_anak.jpg"),
          const SizedBox(height: 20),
          const Text(
            "Tujuan Kami",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit...",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () {}, child: const Text("Tentang Kami")),
        ],
      ),
    );
  }
}
