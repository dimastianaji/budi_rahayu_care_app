import 'package:flutter/material.dart';
import 'package:budi_rahayu_care_app/shared/widgets/header.dart';
import 'package:budi_rahayu_care_app/shared/widgets/admin_bottom_nav.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Header(),

                // Judul Halaman
                const Center(
                  child: Text(
                    'Laporan Donasi',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Grafik Area Chart
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CustomPaint(
                          painter: AreaChartPainter(),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Text('January', style: TextStyle(fontSize: 12)),
                            Text('March', style: TextStyle(fontSize: 12)),
                            Text('April', style: TextStyle(fontSize: 12)),
                            Text('May', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Box Informasi
                _buildInfoBox(title: "Total Donasi Bulan Ini", value: "Rp 12.450.000"),
                const SizedBox(height: 20),
                _buildInfoBox(title: "Jumlah Donatur Aktif", value: "57 Orang"),
                const SizedBox(height: 20),

                // Tombol Logout
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Logout kembali ke halaman login admin
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // Navbar bawah
      bottomNavigationBar: const AdminBottomNav(currentIndex: 0),
    );
  }

  Widget _buildInfoBox({required String title, required String value}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffE3E9FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(value,
              style: const TextStyle(fontSize: 16, color: Colors.black87)),
        ],
      ),
    );
  }
}

// Custom Painter untuk grafik area sederhana
class AreaChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4A90E2)
      ..style = PaintingStyle.fill;

    final paintLine = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.4,
        size.width * 0.5, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.2,
        size.width, size.height * 0.5);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);

    // Garis putih di atas area biru
    final linePath = Path();
    linePath.moveTo(0, size.height * 0.7);
    linePath.quadraticBezierTo(size.width * 0.25, size.height * 0.4,
        size.width * 0.5, size.height * 0.6);
    linePath.quadraticBezierTo(size.width * 0.75, size.height * 0.2,
        size.width, size.height * 0.5);

    canvas.drawPath(linePath, paintLine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
