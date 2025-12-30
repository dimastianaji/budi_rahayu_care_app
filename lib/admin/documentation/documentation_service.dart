import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:budi_rahayu_care_app/admin/documentation/documentation_model.dart';

class DocumentationService {
  static final _client = Supabase.instance.client;
  static const table = 'documentation';
  static const bucket = 'documentation-images';

  // READ (User & Admin)
  static Future<List<Documentation>> getAll() async {
    final res = await _client
        .from(table)
        .select()
        .order('created_at', ascending: false);

    return (res as List)
        .map((e) => Documentation.fromMap(e))
        .toList();
  }

  // CREATE (Admin)
  static Future<void> create({
    required String title,
    Uint8List? imageBytes,
    String? imageName,
  }) async {
    String? imageUrl;

    if (imageBytes != null && imageName != null) {
      final path = '${DateTime.now().millisecondsSinceEpoch}_$imageName';

      await _client.storage
          .from(bucket)
          .uploadBinary(path, imageBytes);

      imageUrl = _client.storage
          .from(bucket)
          .getPublicUrl(path);
    }

    await _client.from(table).insert({
      'title': title,
      'image_url': imageUrl,
    });
  }

  // UPDATE (Admin)
  static Future<void> update({
    required String id,
    required String title,
    String? imageUrl,
  }) async {
    await _client.from(table).update({
      'title': title,
      'image_url': imageUrl,
    }).eq('id', id);
  }

  // DELETE (Admin)
  static Future<void> delete(String id) async {
    await _client.from(table).delete().eq('id', id);
  }
}
