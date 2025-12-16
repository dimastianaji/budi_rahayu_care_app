// lib/core/supabase/supabase_client.dart
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseClientHelper {
  static SupabaseClient get client => Supabase.instance.client;
}
