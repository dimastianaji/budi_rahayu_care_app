import 'package:flutter/material.dart';
import 'package:budi_rahayu_care_app/home/view/home_page.dart';
import 'package:budi_rahayu_care_app/contact/view/kontak_kami_page.dart';
import 'package:budi_rahayu_care_app/about/view/tentang_page.dart';
import 'package:budi_rahayu_care_app/children/view/children_page.dart';
import 'package:budi_rahayu_care_app/news/news/news_page.dart';
import 'package:budi_rahayu_care_app/admin/admin_login_page.dart';
import 'package:budi_rahayu_care_app/admin/admin_dashboard_page.dart';
import 'package:budi_rahayu_care_app/admin/admin_edit_children_page.dart';
import 'package:budi_rahayu_care_app/admin/admin_edit_news_page.dart'; 
import 'package:budi_rahayu_care_app/admin/admin_edit_docs_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Budi Rahayu Care',
      initialRoute: '/', 
      routes: {
        '/': (context) => const HomePage(),
        '/about': (context) => const TentangPage(),
        '/contact': (context) => const KontakKamiPage(),
        '/children': (context) => const ChildrenPage(),
        '/news': (context) => const NewsPage(),
        '/adminLogin': (context) => const AdminLoginPage(),
        '/adminDashboard': (context) => const AdminDashboardPage(),
        '/adminEditChildren': (context) => const AdminEditChildrenPage(),
        '/adminEditNews': (context) => const AdminEditNewsPage(),
        '/adminEditDocs': (context) => const AdminEditDocsPage(),
      },
    );
  }
}
