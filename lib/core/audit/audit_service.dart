import 'package:supabase_flutter/supabase_flutter.dart';

class AuditService {
  static final _client = Supabase.instance.client;

  static Future<void> log({
    required String action,
    required String table,
    String? recordId,
    Map<String, dynamic>? metadata,
  }) async {
    await _client.rpc(
      'log_admin_action',
      params: {
        'p_action': action,
        'p_table': table,
        'p_record_id': recordId,
        'p_metadata': metadata ?? {},
      },
    );
  }
}
