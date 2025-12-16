import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminGuard extends StatelessWidget {
  final Widget child;

  const AdminGuard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      Future.microtask(() {
        Navigator.pushReplacementNamed(context, '/login');
      });
      return const SizedBox();
    }

    return FutureBuilder(
      future: Supabase.instance.client
          .from('profiles')
          .select('role')
          .eq('id', user.id)
          .single(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final role = snapshot.data!['role'];

        if (role != 'admin') {
          Future.microtask(() {
            Navigator.pushReplacementNamed(context, '/unauthorized');
          });
          return const SizedBox();
        }

        return child;
      },
    );
  }
}
