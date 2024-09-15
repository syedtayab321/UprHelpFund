import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/Portals/AdminPortal/AdminDashboardScreen.dart';
import 'package:upr_fund_collection/CustomWidgets/Snakbar.dart';
import 'package:upr_fund_collection/Portals/StudentPortal/StudentDashboard.dart';
import 'package:upr_fund_collection/Login.dart';
import 'package:upr_fund_collection/Models/AuthenticationModel.dart';
import 'package:upr_fund_collection/Models/LoginSharedPrefrencses.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService _authService = AuthService();
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
                Get.off(() => LoginPage(),
                    transition: Transition.fadeIn, duration: Duration(seconds: 2));
              });
    // _checkLoginStatus();
  }
  Future<void> _checkLoginStatus() async {
    String? uid = await _authService.getUserFromPreferences();
    if (uid != null) {
      UserModel? userModel = await _authService.getUserRole(uid);
      if (userModel != null) {
        if (userModel.role == 'Admin') {
          Timer(Duration(seconds: 5), () {
            Get.off(() => AdminDashboardPage(),
                transition: Transition.fadeIn, duration: Duration(seconds: 2));
          });
        } else if(userModel.role == 'Student') {
          Timer(Duration(seconds: 5), () {
            Get.off(() => Studentdashboard(),
                transition: Transition.fadeIn, duration: Duration(seconds: 2));
          });
        }else if(userModel.role == 'ADSA') {
          Timer(Duration(seconds: 5), () {
            Get.off(() => Studentdashboard(),
                transition: Transition.fadeIn, duration: Duration(seconds: 2));
          });
        }else if(userModel.role == 'CR') {
          Timer(Duration(seconds: 5), () {
            Get.off(() => Studentdashboard(),
                transition: Transition.fadeIn, duration: Duration(seconds: 2));
          });
        }
      }
      else
      {
        showErrorSnackbar(uid);
      }
    } else {
      Timer(Duration(seconds: 5), () {
        Get.off(() => LoginPage(),
            transition: Transition.fadeIn, duration: Duration(seconds: 2));
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade700, Colors.black],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(seconds: 2),
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.2),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.volunteer_activism_rounded,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Upr Help Fund",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Making a Difference Together",
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}