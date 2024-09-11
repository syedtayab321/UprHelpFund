import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:upr_fund_collection/Portals/ADSAPortal/AdsaDashboard.dart';
import 'package:upr_fund_collection/Portals/AdminPortal/AdminDashboardScreen.dart';
import 'package:upr_fund_collection/CustomWidgets/Snakbar.dart';
import 'package:upr_fund_collection/Portals/StudentPortal/StudentDashboard.dart';
import 'package:upr_fund_collection/Models/AuthenticationModel.dart';
import 'package:upr_fund_collection/Models/LoginSharedPrefrencses.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService authService = AuthService();

  Future<void> login() async {
    isLoading.value = false;
    if (emailController.text != '' && passwordController.text != '') {
      isLoading.value = true;
      try {
        User? user = await authService.signIn(emailController.text, passwordController.text);
        if (user != null) {
          isLoading.value = false;
          await authService.saveUserToPreferences(user.uid);
          String? uid = await authService.getUserFromPreferences();
          UserModel? userModel = await authService.getUserRole(uid!);
          if (userModel != null) {
            isLoading.value = false;
            if (userModel.role == 'Admin') {
              Get.offAll(() => AdminDashboardPage(), transition: Transition.fadeIn, duration: Duration(seconds: 2));
              showSuccessSnackbar('Login Successfully');
            } else if (userModel.role == 'User') {
              Get.offAll(() => Donordashboard(), transition: Transition.fadeIn, duration: Duration(seconds: 2));
              showSuccessSnackbar('Login Successfully');
            }else if (userModel.role == 'ADSA') {
              Get.offAll(() => ADSADashboardPage(), transition: Transition.fadeIn, duration: Duration(seconds: 2));
              showSuccessSnackbar('Login Successfully');
            }else if (userModel.role == 'CR') {
              Get.offAll(() => Donordashboard(), transition: Transition.fadeIn, duration: Duration(seconds: 2));
              showSuccessSnackbar('Login Successfully');
            }
          } else {
            isLoading.value = false;
            showErrorSnackbar('User role not found.');
          }
        } else {
          isLoading.value = false;
          showErrorSnackbar('Wrong Credentials');
        }
      } catch (e) {
        isLoading.value = false;
        showErrorSnackbar('Error: Wrong Cridentials');
      }
    } else {
      isLoading.value = false;
      showErrorSnackbar('Please fill all the fields first');
    }
  }
}
