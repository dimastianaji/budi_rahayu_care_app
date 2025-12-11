import 'package:flutter/material.dart';
import 'package:budi_rahayu_care_app/shared/widgets/header.dart';
import 'package:budi_rahayu_care_app/shared/widgets/bottom_nav.dart';

class DonatePage extends StatefulWidget {
  const DonatePage({super.key});

  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  final TextEditingController namaC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController nomorC = TextEditingController();
  final TextEditingController jumlahC = TextEditingController();
  final TextEditingController pesanC = TextEditingController();

  // Validasi email
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Snackbar ERROR
  void showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Validasi semua field
  bool validate() {
    if (namaC.text.isEmpty ||
        emailC.text.isEmpty ||
        nomorC.text.isEmpty ||
        jumlahC.text.isEmpty) {
      showError("Semua field bertanda * wajib diisi.");
      return false;
    }

    if (!isValidEmail(emailC.text)) {
      showError("Format email tidak valid.");
      return false;
    }

    if (int.tryParse(nomorC.text) == null) {
      showError("Nomor telepon hanya boleh berisi angka.");
      return false;
    }

    if (int.tryParse(jumlahC.text) == null) {
      showError("Jumlah donasi harus angka.");
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Header(),

              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                child: const Text(
                  "Memberdayakan Masa Depan Anak-anak\nYayasan Yatim Piatu Al Barokah",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildLabel("Nama*"),
                    buildField(controller: namaC),

                    buildLabel("Email*"),
                    buildField(controller: emailC),

                    buildLabel("Nomor*"),
                    buildField(
                      controller: nomorC,
                      keyboard: TextInputType.number,
                    ),

                    buildLabel("Jumlah (Rp)*"),
                    buildField(
                      controller: jumlahC,
                      keyboard: TextInputType.number,
                    ),

                    buildLabel("Pesan"),
                    buildField(controller: pesanC, maxLines: 4),

                    const SizedBox(height: 20),

                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (!validate()) return;

                            Navigator.pushNamed(
                              context,
                              '/payment',
                              arguments: {
                                'nama': namaC.text,
                                'email': emailC.text,
                                'nomor': nomorC.text,
                                'jumlah': jumlahC.text,
                                'pesan': pesanC.text,
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff05049F),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text(
                            "Pilih Metode Pembayaran",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNav(currentIndex: 2, onItemTapped: (_) {}),
    );
  }

  Widget buildLabel(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 6, top: 14),
        child: Text(
          text,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      );

  Widget buildField({
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType keyboard = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboard,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF1F2F6),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.black54),
        ),
      ),
    );
  }
}
