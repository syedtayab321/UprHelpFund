import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/ConfirmDialogBox.dart';
import 'package:upr_fund_collection/CustomWidgets/ElevatedButton.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';
import 'package:upr_fund_collection/Models/LoginSharedPrefrencses.dart';

class AdsaProfilePage extends StatelessWidget {
  final AuthService _authService = AuthService();

  void logout(BuildContext context) async {
    await Get.dialog(
      ConfirmDialog(
        title: 'Logout',
        content: 'Are you sure you want to logout?',
        confirmText: 'Confirm',
        cancelText: 'Cancel',
        onConfirm: () {
          _authService.signOut();
        },
        onCancel: () {
          Get.back();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Adsa Profile'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextWidget(
              title: 'UPR HELP FUND',
              size: 28,
              weight: FontWeight.bold,
              color: Colors.teal.shade700,
            ),
            SizedBox(height: 10),
            TextWidget(
              title: 'http://www.upr.edu.pk',
              size: 18,
              color: Colors.grey[700],
            ),
            SizedBox(height: 30),
            Divider(height: 20, thickness: 2),
            TextWidget(
              title: 'App Information',
              size: 22,
              weight: FontWeight.bold,
              color: Colors.teal.shade700,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.store, color:Colors.teal.shade700),
                SizedBox(width: 10),
                Expanded(
                  child: TextWidget(
                      title: 'University Help Fund is a dedicated platform designed to support students and faculty in raising funds for various university-related causes. ',
                      size: 16, color: Colors.grey[800]),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.local_shipping, color: Colors.teal.shade700),
                SizedBox(width: 10),
                Expanded(
                  child: TextWidget(
                      title: 'Whether it"s for scholarships, research projects, campus improvements, or student activities, our app provides a seamless way for donors to contribute and make a difference',
                      size: 16, color: Colors.grey[800]
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(height: 20, thickness: 2),
            Spacer(),
            Elevated_button(
              text: 'Logout',
              color: Colors.white,
              path: () {
                logout(context);
              },
              padding: 12,
              radius: 10,
              width: Get.width,
              height: 50,
              backcolor: Colors.red,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
