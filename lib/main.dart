import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:stripe_payment/stripe_payment.dart';
void main() async{
  StripePayment.setOptions(
    StripeOptions(
      publishableKey: "pk_test_51Prg2QIAaNMFjiXFDNCRkf0d50lpFubBDwCmTAQppx26DSXKnLFb4Ol0uTnzSKukWyDtp7XRXlA3tU4RjaMVhe1O00mdeZBaws",
      androidPayMode: 'test', // use 'production' for live apps
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Upr Help Fund',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
      ],
    );
  }
}