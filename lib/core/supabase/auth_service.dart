// lib/core/supabase/auth_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_client.dart';

class AuthService {
  final SupabaseClient _client = SupabaseClientHelper.client;

  /// LOGIN ADMIN + VALIDASI ROLE
  Future<void> signInAdmin({
    required String email,
    required String password,
  }) async {
    // 1️⃣ Login ke Supabase Auth
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final user = response.user;

    if (user == null) {
      throw const AuthException('Login gagal');
    }

    // 2️⃣ Ambil role dari tabel profiles
    final profile = await _client
        .from('profiles')
        .select('role')
        .eq('id', user.id)
        .single();

    // 3️⃣ Validasi role admin
    if (profile['role'] != 'admin') {
      await _client.auth.signOut();
      throw const AuthException('Akun ini bukan admin');
    }
  }

  /// LOGOUT
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  /// CURRENT USER
  User? get currentUser => _client.auth.currentUser;
}
