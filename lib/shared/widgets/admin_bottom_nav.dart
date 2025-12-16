import 'package:flutter/material.dart';

class AdminBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemTapped;

  const AdminBottomNav({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onItemTapped,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xff05049F),
      unselectedItemColor: Colors.grey[600],
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'lib/shared/assets/icons/icon_home.png',
            width: 24,
            color: currentIndex == 0
                ? const Color(0xff05049F)
                : Colors.grey[600],
          ),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'lib/shared/assets/icons/icon_children.png',
            width: 24,
            color: currentIndex == 1
                ? const Color(0xff05049F)
                : Colors.grey[600],
          ),
          label: 'Data Anak',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'lib/shared/assets/icons/icon_news.png',
            width: 24,
            color: currentIndex == 2
                ? const Color(0xff05049F)
                : Colors.grey[600],
          ),
          label: 'Berita',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'lib/shared/assets/icons/icon_camera.png',
            width: 24,
            color: currentIndex == 3
                ? const Color(0xff05049F)
                : Colors.grey[600],
          ),
          label: 'Dokumentasi',
        ),
      ],
    );
  }
}