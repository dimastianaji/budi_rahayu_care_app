import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminGuard extends StatefulWidget {
  final Widget child;

  const AdminGuard({super.key, required this.child});

  @override
  State<AdminGuard> createState() => _AdminGuardState();
}

class _AdminGuardState extends State<AdminGuard> {
  bool _loading = true;
  bool _authorized = false;

  @override
  void initState() {
    super.initState();
    _checkAdmin();
  }

  Future<void> _checkAdmin() async {
    final client = Supabase.instance.client;
    final user = client.auth.currentUser;

    if (user == null) {
      _redirectToLogin();
      return;
    }

    final profile = await client
        .from('profiles')
        .select('role')
        .eq('id', user.id)
        .single();

    if (profile['role'] == 'admin') {
      setState(() {
        _authorized = true;
        _loading = false;
      });
    } else {
      _redirectUnauthorized();
    }
  }

  void _redirectToLogin() {
    Navigator.pushReplacementNamed(context, '/adminLogin');
  }

  void _redirectUnauthorized() {
    Navigator.pushReplacementNamed(context, '/unauthorized');
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return _authorized ? widget.child : const SizedBox();
  }
}
