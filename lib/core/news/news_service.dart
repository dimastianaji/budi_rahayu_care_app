import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

class NewsService {
  static final SupabaseClient _client = Supabase.instance.client;

  static const String table = 'news';
  static const String bucket = 'news-images';

  /* =======================
   * PUBLIC (USER)
   * ======================= */

  /// Ambil semua berita
  static Future<List<Map<String, dynamic>>> getAllNews() async {
    final response = await _client
        .from(table)
        .select()
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  /// Ambil detail berita
  static Future<Map<String, dynamic>?> getNewsById(String id) async {
    final response = await _client
        .from(table)
        .select()
        .eq('id', id)
        .maybeSingle();

    return response;
  }

  /* =======================
   * STORAGE
   * ======================= */

  /// Upload gambar berita
  static Future<String> uploadNewsImage({
    required Uint8List bytes,
    required String fileName,
  }) async {
    final path = 'news/$fileName';

    await _client.storage.from(bucket).uploadBinary(
          path,
          bytes,
          fileOptions: const FileOptions(upsert: true),
        );

    return _client.storage.from(bucket).getPublicUrl(path);
  }

  /// Hapus gambar berita
  static Future<void> deleteNewsImage(String imageUrl) async {
    final path = imageUrl.split('$bucket/').last;
    await _client.storage.from(bucket).remove([path]);
  }

  /* =======================
   * ADMIN
   * ======================= */

  /// Tambah berita
  static Future<void> createNews({
    required String title,
    required String content,
    String? imageUrl,
  }) async {
    await _client.from(table).insert({
      'title': title,
      'content': content,
      'image_url': imageUrl,
    });
  }

  /// Update berita
  static Future<void> updateNews({
    required String id,
    required String title,
    required String content,
    String? imageUrl,
  }) async {
    final data = {
      'title': title,
      'content': content,
    };

    if (imageUrl != null) {
      data['image_url'] = imageUrl;
    }

    await _client.from(table).update(data).eq('id', id);
  }

  /// Hapus berita + gambar
  static Future<void> deleteNews({
    required String id,
    String? imageUrl,
  }) async {
    if (imageUrl != null) {
      await deleteNewsImage(imageUrl);
    }

    await _client.from(table).delete().eq('id', id);
  }
}
