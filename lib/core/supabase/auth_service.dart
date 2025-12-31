// lib/core/supabase/auth_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_client.dart';

class AuthService {
  final SupabaseClient _client = SupabaseClientHelper.client;

  /// LOGIN ADMIN (HANYA AUTH)
  Future<void> signInAdmin({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw const AuthException('Login gagal');
    }

    // ❌ JANGAN cek role di sini
    // ❌ JANGAN query profiles di sini
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  User? get currentUser => _client.auth.currentUser;
}