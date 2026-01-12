import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

class NewsService {
  static final SupabaseClient _client = Supabase.instance.client;

  static const String table = 'news';
  static const String bucket = 'news-images';

  /* =======================
   * PUBLIC (USER)
   * ======================= */

  /// Ambil semua berita (publik)
  static Future<List<Map<String, dynamic>>> getAllNews() async {
    final response = await _client
        .from(table)
        .select()
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  /// Ambil detail berita berdasarkan ID
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

  /// Upload gambar berita ke Supabase Storage
static Future<String> uploadNewsImage({
  required Uint8List bytes,
  required String fileName,
}) async {
  final session = _client.auth.currentSession;
  if (session == null) {
    throw Exception('User harus login untuk mengupload gambar.');
  }

  final path = 'news/$fileName';

  try {
    // Upload gambar
    await _client.storage.from(bucket).uploadBinary(
          path,
          bytes,
          fileOptions: const FileOptions(
            upsert: true,
            contentType: 'image/jpeg',
          ),
        );

    // ✅ DEBUG: Print URL yang dihasilkan
    final publicUrl = _client.storage.from(bucket).getPublicUrl(path);
    print('✅ Gambar berhasil diupload. URL: $publicUrl');

    return publicUrl;
  } catch (e) {
    print('❌ Error upload gambar: $e');
    throw Exception('Gagal upload gambar berita: $e');
  }
}

  /// Hapus gambar berita dari Supabase Storage
  static Future<void> deleteNewsImage(String imageUrl) async {
    try {
      // Ekstrak path: contoh URL:
      // https://xxx.supabase.co/storage/v1/object/news-images/news/123.jpg
      final startIndex = imageUrl.indexOf('$bucket/');
      if (startIndex == -1) {
        throw Exception('URL tidak valid: tidak mengandung bucket "$bucket"');
      }
      final path = imageUrl.substring(startIndex + '$bucket/'.length);

      await _client.storage.from(bucket).remove([path]);
    } catch (e) {
      throw Exception('Gagal menghapus gambar berita: $e');
    }
  }

  /* =======================
   * ADMIN
   * ======================= */

  /// Tambah berita baru
  static Future<void> createNews({
    required String title,
    required String content,
    String? imageUrl,
  }) async {
    try {
      await _client.from(table).insert({
        'title': title,
        'content': content,
        'image_url': imageUrl,
      });
    } catch (e) {
      throw Exception('Gagal menambahkan berita: $e');
    }
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

    try {
      await _client.from(table).update(data).eq('id', id);
    } catch (e) {
      throw Exception('Gagal memperbarui berita: $e');
    }
  }

  /// Hapus berita beserta gambarnya
  static Future<void> deleteNews({
    required String id,
    String? imageUrl,
  }) async {
    try {
      if (imageUrl != null) {
        await deleteNewsImage(imageUrl);
      }

      await _client.from(table).delete().eq('id', id);
    } catch (e) {
      throw Exception('Gagal menghapus berita: $e');
    }
  }
}