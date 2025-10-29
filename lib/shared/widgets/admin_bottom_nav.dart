import 'package:flutter/material.dart';
import 'package:budi_rahayu_care_app/admin/dashboard/admin_dashboard_page.dart';
import 'package:budi_rahayu_care_app/admin/children/view/admin_children_page.dart';
import 'package:budi_rahayu_care_app/admin/news/admin_edit_news_page.dart';
import 'package:budi_rahayu_care_app/admin/documentation/admin_edit_docs_page.dart';

class AdminBottomNav extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int>? onItemTapped;

  const AdminBottomNav({
    super.key,
    required this.currentIndex,
    this.onItemTapped,
  });

  @override
  State<AdminBottomNav> createState() => _AdminBottomNavState();
}

class _AdminBottomNavState extends State<AdminBottomNav> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
        widget.onItemTapped?.call(index);

        // Navigasi antar halaman admin
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AdminDashboardPage()),
            );
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AdminChildrenPage()),
            );
            break;
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AdminEditNewsPage()),
            );
            break;
          case 3:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AdminEditDocsPage()),
            );
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xff05049F),
      unselectedItemColor: Colors.grey[600],
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'lib/shared/assets/icons/icon_home.png',
            width: 24,
            height: 24,
            color: _selectedIndex == 0 ? const Color(0xff05049F) : Colors.grey[600],
          ),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'lib/shared/assets/icons/icon_children.png',
            width: 24,
            height: 24,
            color: _selectedIndex == 1 ? const Color(0xff05049F) : Colors.grey[600],
          ),
          label: 'Data Anak',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'lib/shared/assets/icons/icon_news.png',
            width: 24,
            height: 24,
            color: _selectedIndex == 2 ? const Color(0xff05049F) : Colors.grey[600],
          ),
          label: 'Berita',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'lib/shared/assets/icons/icon_camera.png',
            width: 24,
            height: 24,
            color: _selectedIndex == 3 ? const Color(0xff05049F) : Colors.grey[600],
          ),
          label: 'Dokumentasi',
        ),
      ],
    );
  }
}
