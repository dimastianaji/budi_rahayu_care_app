import 'package:flutter/material.dart';
import 'package:budi_rahayu_care_app/shared/widgets/header.dart';
import 'package:budi_rahayu_care_app/shared/widgets/bottom_nav.dart';

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data donasi dari halaman sebelumnya
    final dataDonasi = (ModalRoute.of(context)?.settings.arguments ?? {}) as Map;

    void goToDetail(String metode) {
      Navigator.pushNamed(
        context,
        '/detail-payment',
        arguments: {
          ...dataDonasi,
          'metode': metode,
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(),

            // 🔙 Back button
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 22),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "Metode Pembayaran",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 28),

            // 🟦 Card Pilihan Pembayaran
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  paymentCard(
                    "QRIS",
                    "lib/shared/assets/icons/payments/qris.png",
                    () => goToDetail("QRIS"),
                  ),
                  paymentCard(
                    "Transfer Bank",
                    "lib/shared/assets/icons/payments/bank.png",
                    () => goToDetail("TRANSFER"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(currentIndex: 2, onItemTapped: (_) {}),
    );
  }

  Widget paymentCard(String label, String asset, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          children: [
            Image.asset(asset, height: 40),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
