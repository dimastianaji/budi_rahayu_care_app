import 'package:flutter/material.dart';
import 'package:budi_rahayu_care_app/shared/widgets/header.dart';
import 'package:budi_rahayu_care_app/shared/widgets/bottom_nav.dart';

class TentangPage extends StatelessWidget {
  const TentangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100), // beri ruang agar tidak tertutup bottom bar
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Header(),

              // Judul Halaman
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                child: const Center(
                  child: Text(
                    'Yayasan Yatim Piatu Budi Rahayu Al Barokah',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),

              // Teks Deskripsi
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Yayasan Yatim Piatu Budi Rahayu Al-Barokah merupakan panti asuhan yang berlokasi di Kabupaten Banyumas. Yayasan ini berkomitmen untuk merawat dan mendidik anak-anak yatim piatu serta anak-anak dhuafa agar dapat tumbuh menjadi generasi yang mandiri dan berakhlak baik.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Yayasan Yatim Piatu Budi Rahayu Al-Barokah menyediakan berbagai kebutuhan anak-anak asuhnya, mulai dari kebutuhan pokok seperti makanan, pakaian, hingga biaya pendidikan. Berdirinya yayasan ini berawal dari kepedulian Ibu Anik terhadap anak-anak yang kurang beruntung. Salah satu kisah awalnya adalah ketika beliau merawat anak dari pasangan tunanetra yang berprofesi sebagai tukang pijat dan tidak mampu mengasuh anaknya sendiri.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Awalnya, panti ini berdiri di daerah Sawangan dan dikelola langsung oleh Ibu Anik. Namun, karena kesibukannya sebagai penyanyi yang sering bepergian ke Jakarta, pengelolaan sementara sempat diserahkan kepada sepasang suami istri. Seiring berjalannya waktu, muncul kendala dalam pengelolaan dan masa kontrak rumah pun berakhir, sehingga Ibu Anik memutuskan untuk mencari tempat baru.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Beliau kemudian menemukan tempat tinggal di rumah milik Bapak Bagong di daerah Kober, Purwokerto. Dengan penuh kebaikan, Bapak Bagong memberikan salah satu rumahnya untuk digunakan sebagai tempat tinggal sementara anak-anak panti. Namun, karena jumlah anak asuh yang semakin banyak, beberapa fasilitas mengalami kerusakan. Hal ini mendorong Ibu Anik untuk mencari lokasi baru dan membangun panti asuhan sendiri.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Tanah yang dipilih merupakan bekas empang (belumbang) yang sudah tidak digunakan oleh pemiliknya karena faktor usia. Proses pembangunan Yayasan Yatim Piatu Budi Rahayu Al-Barokah dimulai pada tahun 2018 dan selesai pada tahun 2019. Pada tahun yang sama, panti mulai beroperasi secara resmi.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Kini, Yayasan Yatim Piatu Budi Rahayu Al-Barokah telah mendapatkan akreditasi bintang empat dari Dinas Sosial, sebagai pengakuan atas pengelolaan yang baik dan sesuai standar. Berbagai program pendidikan dan kegiatan positif dijalankan untuk mengembangkan potensi anak-anak, baik dalam bidang akademik maupun non-akademik.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Anak-anak asuh di yayasan ini telah meraih berbagai prestasi, seperti Juara 1 dan Juara 3 Lomba Dokter Kecil tingkat Kabupaten Banyumas, serta banyak penghargaan lainnya di berbagai bidang.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Selain pendidikan formal di tingkat SD, SMP, SMA, hingga perguruan tinggi, anak-anak juga aktif dalam kegiatan keagamaan seperti salat berjamaah, mengaji, pengajian rutin, dan berbagai kegiatan positif lainnya. Yayasan juga menyediakan fasilitas yang nyaman, termasuk tempat tinggal yang layak, akses internet, dan perlengkapan belajar.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Yayasan Yatim Piatu Budi Rahayu Al-Barokah terbuka bagi para donatur dan masyarakat yang ingin berbagi kebaikan. Proses penerimaan anak asuh dilakukan secara langsung di panti bersama orang tua atau wali, dengan memenuhi persyaratan yang telah ditetapkan.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Dengan semangat kasih dan kepedulian, kami terus berupaya menciptakan lingkungan yang aman, nyaman, dan penuh cinta untuk anak-anak penerus bangsa.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Gambar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'lib/shared/assets/images/foto_tentang.jpeg',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Tombol di bawah gambar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/contact');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff05049F),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Hubungi Kami',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 48),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/adminLogin');
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xff05049F), width: 2),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Login Administrator',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff05049F),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
      

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNav(
        currentIndex: 4,
        onItemTapped: (index) {
          // misalnya handle navigasi di sini
        },
      ),
    );
  }
}
