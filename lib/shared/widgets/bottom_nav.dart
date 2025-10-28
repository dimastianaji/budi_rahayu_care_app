import 'package:flutter/material.dart';
import 'package:budi_rahayu_care_app/home/view/home_page.dart';

class BottomNav extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int>? onItemTapped;

  const BottomNav({
    super.key,
    required this.currentIndex,
    this.onItemTapped,
  });

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
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

        // Navigasi sesuai index
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/children');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/donate');
            break;
          case 3:
            Navigator.pushReplacementNamed(context, '/news');
            break;
          case 4:
            Navigator.pushReplacementNamed(context, '/about');
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey[600],
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'lib/shared/assets/icons/icon_home.png',
            width: 24,
            height: 24,
            color: _selectedIndex == 0 ? Colors.blue : Colors.grey[600],
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'lib/shared/assets/icons/icon_children.png',
            width: 24,
            height: 24,
            color: _selectedIndex == 1 ? Colors.blue : Colors.grey[600],
          ),
          label: 'Anak',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'lib/shared/assets/icons/icon_donate.png',
            width: 24,
            height: 24,
            color: _selectedIndex == 2 ? Colors.blue : Colors.grey[600],
          ),
          label: 'Donasi',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'lib/shared/assets/icons/icon_news.png',
            width: 24,
            height: 24,
            color: _selectedIndex == 3 ? Colors.blue : Colors.grey[600],
          ),
          label: 'Berita',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'lib/shared/assets/icons/icon_about.png',
            width: 24,
            height: 24,
            color: _selectedIndex == 4 ? Colors.blue : Colors.grey[600],
          ),
          label: 'Tentang',
        ),
      ],
    );
  }
}
