import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:upr_fund_collection/Controllers/BottomBarController.dart';
import 'package:upr_fund_collection/CustomWidgets/ConfirmDialogBox.dart';
import 'package:upr_fund_collection/CustomWidgets/ElevatedButton.dart';
import 'package:upr_fund_collection/CustomWidgets/IconButton.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';
import 'package:upr_fund_collection/Models/LoginSharedPrefrencses.dart';

class Donordashboard extends StatelessWidget {
  final DonorBottomBarController _controller = Get.put(DonorBottomBarController());
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
        title: TextWidget(title: 'User Dashboard',color: Colors.white,),
        backgroundColor: Colors.teal.shade700,
        actions: [
          Elevated_button(
            text: 'Logout',
            color: Colors.white,
            path: () {
              logout(context);
            },
            radius: 10,
            padding: 3,
            width: 130,
            height: 40,
            backcolor: Colors.red.shade800,
          ),
        ],
      ),
      body: Obx(() {
        return _controller.pages[_controller.selectedIndex.value];
      }),
      bottomNavigationBar: Obx(() {
        return ConvexAppBar(
          backgroundColor: Colors.teal.shade700,
          color: Colors.white,
          activeColor: Colors.white,
          style: TabStyle.reactCircle,
          items: [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.content_paste_go_outlined, title: 'Donotions'),
            TabItem(icon: Icons.request_page, title: 'Requests'),
            TabItem(icon: Icons.notifications, title: 'Notification'),
            TabItem(icon: Icons.person, title: 'Profile'),
          ],
          initialActiveIndex: _controller.selectedIndex.value,
          onTap: _controller.onItemTapped,
          height: 65,
          curveSize: 0,
        );
      }),
    );
  }
}
