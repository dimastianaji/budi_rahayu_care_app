import 'package:flutter/material.dart';
import 'package:budi_rahayu_care_app/shared/widgets/admin_bottom_nav.dart';

class AdminEditChildrenPage extends StatelessWidget {
  const AdminEditChildrenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Data Anak'),
        backgroundColor: const Color(0xff05049F),
      ),
      body: const Center(child: Text('Halaman Edit Data Anak')),
      bottomNavigationBar: const AdminBottomNav(currentIndex: 1),
    );
  }
}
