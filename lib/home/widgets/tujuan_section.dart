import 'package:flutter/material.dart';

class TujuanSection extends StatelessWidget {
  const TujuanSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffe0e0e0),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Tujuan Kami',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xff343434),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Color(0xff343434)),
          ),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.blue[900],
              side: const BorderSide(color: Color(0xff05049F)),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Tentang Kami',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
