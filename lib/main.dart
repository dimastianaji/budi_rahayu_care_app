import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:budi_rahayu_care_app/home/view/home_page.dart';
import 'package:budi_rahayu_care_app/contact/view/kontak_kami_page.dart';
import 'package:budi_rahayu_care_app/about/view/tentang_page.dart';
import 'package:budi_rahayu_care_app/children/view/children_page.dart';
import 'package:budi_rahayu_care_app/news/news/news_page.dart';
import 'package:budi_rahayu_care_app/admin/admin_login_page.dart';
import 'package:budi_rahayu_care_app/admin/dashboard/admin_dashboard_page.dart';
import 'package:budi_rahayu_care_app/admin/children/view/admin_children_page.dart';
import 'package:budi_rahayu_care_app/admin/news/admin_news_page.dart'; 
import 'package:budi_rahayu_care_app/admin/documentation/admin_edit_docs_page.dart';
import 'package:budi_rahayu_care_app/donation/pages/donate_page.dart';
import 'package:budi_rahayu_care_app/donation/view/payment_method_page.dart';
import 'package:budi_rahayu_care_app/donation/view/detail_payment_page.dart';
import 'package:budi_rahayu_care_app/donation/view/payment_info_page.dart';
import 'package:budi_rahayu_care_app/donation/view/thank_you_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
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
        '/donate': (context) => const DonatePage(),
        '/news': (context) => const NewsPage(),
        '/payment': (context) => const PaymentMethodPage(),
        '/detail-payment': (_) => const DetailPaymentPage(),
        '/payment-info': (context) => const PaymentInfoPage(),
        '/thank-you': (context) => const ThankYouPage(),
        '/adminLogin': (context) => const AdminLoginPage(),
        '/adminDashboard': (context) => const AdminDashboardPage(),
        '/adminEditChildren': (context) => const AdminChildrenPage(),
        '/adminEditNews': (context) => const AdminNewsPage(),
        '/adminEditDocs': (context) => const AdminDocsPage(),
      },
    );
  }
}
