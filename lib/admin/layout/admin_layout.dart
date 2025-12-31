import 'package:flutter/material.dart';
import 'package:budi_rahayu_care_app/admin/children/view/admin_children_page.dart';
import 'package:budi_rahayu_care_app/admin/news/admin_news_page.dart';
import 'package:budi_rahayu_care_app/admin/documentation/admin_edit_docs_page.dart';
import 'package:budi_rahayu_care_app/admin/dashboard/admin_dashboard_page.dart';
import 'package:budi_rahayu_care_app/shared/widgets/admin_bottom_nav.dart';

class AdminLayout extends StatefulWidget {
  const AdminLayout({super.key});

  @override
  State<AdminLayout> createState() => _AdminLayoutState();
}

class _AdminLayoutState extends State<AdminLayout> {
  int _index = 0;

  final List<Widget> _pages = const [
    AdminDashboardPage(),
    AdminChildrenPage(),
    AdminNewsPage(),
    AdminDocsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: AdminBottomNav(
        currentIndex: _index,
        onItemTapped: (i) {
          setState(() => _index = i);
        },
      ),
    );
  }
}
