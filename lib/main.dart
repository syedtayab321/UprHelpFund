import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/Portals/DonorPortal/MakeDonationPage.dart';
import 'package:upr_fund_collection/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
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