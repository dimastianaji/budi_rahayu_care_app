import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../admin/children/models/child_model.dart';

class ChildService {
  static final _client = Supabase.instance.client;

  static const table = 'children';
  static const bucket = 'child-photos';

  /// ======================
  /// READ
  /// ======================
  static Future<List<ChildModel>> getChildren() async {
    final List data = await _client
        .from(table)
        .select()
        .order('created_at', ascending: false);

    return data
        .map((e) => ChildModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// ======================
  /// UPLOAD FOTO (WEB SAFE)
  /// ======================
  static Future<String> uploadPhoto(
    Uint8List bytes,
    String fileName,
  ) async {
    final path = '${DateTime.now().millisecondsSinceEpoch}_$fileName';

    await _client.storage.from(bucket).uploadBinary(
          path,
          bytes,
          fileOptions: const FileOptions(upsert: true),
        );

    return _client.storage.from(bucket).getPublicUrl(path);
  }

  /// ======================
  /// CREATE
  /// ======================
  static Future<void> addChild({
    required String name,
    required String description,
    required Uint8List photoBytes,
    required String photoName,
  }) async {
    final photoUrl = await uploadPhoto(photoBytes, photoName);

    await _client.from(table).insert({
      'name': name,
      'description': description,
      'photo_url': photoUrl,
    });
  }

  /// ======================
  /// UPDATE
  /// ======================
  static Future<void> updateChild({
    required String id,
    required String name,
    required String description,
  }) async {
    await _client.from(table).update({
      'name': name,
      'description': description,
    }).eq('id', id);
  }

  /// ======================
  /// DELETE
  /// ======================
  static Future<void> deleteChild(String id) async {
    await _client.from(table).delete().eq('id', id);
  }
}
