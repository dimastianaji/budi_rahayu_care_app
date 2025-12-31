import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseTestPage extends StatelessWidget {
  const SupabaseTestPage({super.key});

  Future<String> testSupabase() async {
    try {
      final data = await Supabase.instance.client
        .from('profiles')
        .select('id')
        .limit(1);

      return '✅ Supabase connected\n$data';
    } catch (e) {
      return '❌ Error:\n$e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Supabase Test')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final result = await testSupabase();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(result)));
          },
          child: const Text('Test Supabase'),
        ),
      ),
    );
  }
}
