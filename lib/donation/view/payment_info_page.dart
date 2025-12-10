import 'package:flutter/material.dart';
import 'package:budi_rahayu_care_app/shared/widgets/header.dart';
import 'package:budi_rahayu_care_app/shared/widgets/bottom_nav.dart';

class PaymentInfoPage extends StatelessWidget {
  const PaymentInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    final metode = data['metode'];
    final jumlah = data['jumlah'];

    final bankInfo = {
      "bank": "Bank BCA",
      "norek": "1234567890",
      "nama": "Yayasan Budi Rahayu",
      "logo": "lib/shared/assets/icons/payments/bca.png",
    };

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Header(),

          // 🔙 Tombol Back
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 22),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "Informasi Pembayaran",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F2F6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Metode: $metode",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // === QRIS ===
                    if (metode == "QRIS") ...[
                      Image.asset(
                        "lib/shared/assets/icons/payments/qris.png",
                        width: 220,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Jumlah yang harus dibayar:",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Rp$jumlah",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]

                    // === TRANSFER ===
                    else if (metode == "TRANSFER") ...[
                      Image.asset(bankInfo['logo']!, width: 120),
                      const SizedBox(height: 20),
                      Text(
                        bankInfo['bank']!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        bankInfo['norek']!,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text("A/N ${bankInfo['nama']}"),
                      const SizedBox(height: 16),
                      Text(
                        "Total transfer: Rp$jumlah",
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),

          // 🔵 Tombol "Selesai" — Sudah Seragam
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/thank-you');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff05049F),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                "Selesai",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
      bottomNavigationBar: BottomNav(currentIndex: 2, onItemTapped: (_) {}),
    );
  }
}
