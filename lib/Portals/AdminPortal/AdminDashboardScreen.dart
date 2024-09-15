import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/Controllers/BottomBarController.dart';
import 'package:upr_fund_collection/CustomWidgets/ConfirmDialogBox.dart';
import 'package:upr_fund_collection/CustomWidgets/IconButton.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';
import 'package:upr_fund_collection/Models/LoginSharedPrefrencses.dart';
class AdminDashboardPage extends StatelessWidget {
  final AdminBottomBarController _controller = Get.put(AdminBottomBarController());
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
        title: TextWidget(title: 'Admin Portal',color: Colors.white,),
        backgroundColor: Colors.teal.shade700,
        actions: [
          Icon_Button(onPressed: (){
            logout(context);
          }, icon: Icon(Icons.logout_outlined),color: Colors.white,)
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
            TabItem(icon: Icons.message, title: 'Messages'),
            TabItem(icon: Icons.notifications, title: 'Notifications'),
            TabItem(icon: Icons.person, title: 'Profile'),
          ],
          initialActiveIndex: _controller.selectedIndex.value,
          onTap: _controller.onItemTapped,
          height: 60,
          curveSize: 0,
        );
      }),
    );
  }
}