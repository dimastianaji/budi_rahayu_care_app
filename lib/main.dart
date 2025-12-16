import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:budi_rahayu_care_app/home/view/home_page.dart';
import 'package:budi_rahayu_care_app/contact/view/kontak_kami_page.dart';
import 'package:budi_rahayu_care_app/about/view/tentang_page.dart';
import 'package:budi_rahayu_care_app/children/view/children_page.dart';
import 'package:budi_rahayu_care_app/news/news/news_page.dart';
import 'package:budi_rahayu_care_app/admin/admin_login_page.dart';
import 'package:budi_rahayu_care_app/donation/pages/donate_page.dart';
import 'package:budi_rahayu_care_app/donation/view/payment_method_page.dart';
import 'package:budi_rahayu_care_app/donation/view/detail_payment_page.dart';
import 'package:budi_rahayu_care_app/donation/view/payment_info_page.dart';
import 'package:budi_rahayu_care_app/donation/view/thank_you_page.dart';
import 'package:budi_rahayu_care_app/supabase_test_page.dart';
import 'package:budi_rahayu_care_app/core/guards/admin_guard.dart';
import 'package:budi_rahayu_care_app/admin/layout/admin_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

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
        // ================= PUBLIC =================
        '/': (_) => const HomePage(),
        '/about': (_) => const TentangPage(),
        '/contact': (_) => const KontakKamiPage(),
        '/children': (_) => const ChildrenPage(),
        '/news': (_) => const NewsPage(),
        '/donate': (_) => const DonatePage(),

        // ================= DONATION =================
        '/payment': (_) => const PaymentMethodPage(),
        '/detail-payment': (_) => const DetailPaymentPage(),
        '/payment-info': (_) => const PaymentInfoPage(),
        '/thank-you': (_) => const ThankYouPage(),

        // ================= AUTH =================
        '/adminLogin': (_) => const AdminLoginPage(),

        // ================= ADMIN (ONE ENTRY POINT) =================
        '/admin': (_) => AdminGuard(
              child: const AdminLayout(),
            ),

        // ================= DEV =================
        '/debug-supabase': (_) => const SupabaseTestPage(),
      },
    );
  }
}