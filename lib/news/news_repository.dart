import 'models/news_model.dart';

class NewsRepository {
  static List<NewsModel> getAllNews() {
    return [
      NewsModel(
        title: 'Kegiatan Santunan Anak Yatim',
        description: 'Kegiatan santunan bulanan untuk anak-anak yatim di Panti Asuhan Budi Rahayu.',
        content:
            'Pada tanggal 24 Oktober 2025, telah dilaksanakan kegiatan santunan bagi anak-anak yatim yang diselenggarakan di aula panti...',
        date: '24 Oktober 2025',
        imageUrl: 'lib/shared/assets/images/GambarBerita1.png',
      ),
      NewsModel(
        title: 'Peringatan Hari Kemerdekaan',
        description: 'Anak-anak panti ikut serta dalam lomba 17 Agustus dengan penuh semangat.',
        content:
            'Dalam rangka memperingati Hari Kemerdekaan Indonesia, Panti Asuhan Budi Rahayu mengadakan berbagai lomba seperti balap karung, tarik tambang, dan lain-lain...',
        date: '17 Agustus 2025',
        imageUrl: 'lib/shared/assets/images/GambarBerita1.png',
      ),
      NewsModel(
        title: 'Donasi dari Alumni Sekolah',
        description: 'Terima kasih kepada para alumni yang telah memberikan donasi.',
        content:
            'Kami mengucapkan terima kasih kepada para alumni yang telah menyumbangkan dana serta kebutuhan pokok bagi anak-anak di panti...',
        date: '5 September 2025',
        imageUrl: 'lib/shared/assets/images/GambarBerita1.png',
      ),
    ];
  }
}
