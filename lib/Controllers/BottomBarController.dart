import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:upr_fund_collection/Portals/ADSAPortal/AdsaDashboardComponents/AdsaHomePage.dart';
import 'package:upr_fund_collection/Portals/ADSAPortal/AdsaDashboardComponents/AdsaMessagePage.dart';
import 'package:upr_fund_collection/Portals/ADSAPortal/AdsaDashboardComponents/AdsaNotificationPage.dart';
import 'package:upr_fund_collection/Portals/ADSAPortal/AdsaDashboardComponents/AdsaProfilePage.dart';
import 'package:upr_fund_collection/Portals/AdminPortal/DashboardComponents/AdminNotification.dart';
import 'package:upr_fund_collection/Portals/AdminPortal/DashboardComponents/AdminHomePage.dart';
import 'package:upr_fund_collection/Portals/AdminPortal/DashboardComponents/AdminMessage.dart';
import 'package:upr_fund_collection/Portals/AdminPortal/DashboardComponents/AdminProfile.dart';
import 'package:upr_fund_collection/Portals/StudentPortal/DashboardComponents/StudentHomePage.dart';
import 'package:upr_fund_collection/Portals/StudentPortal/DashboardComponents/StudentNotificationPage.dart';
import 'package:upr_fund_collection/Portals/StudentPortal/DashboardComponents/StudentProfile.dart';
import 'package:upr_fund_collection/Portals/StudentPortal/DashboardComponents/ViewOwnPastDonations.dart';
import 'package:upr_fund_collection/Portals/StudentPortal/DashboardComponents/ViewOwnDonationRequests.dart';


class DonorBottomBarController extends GetxController {
  var selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> pages = [
        StudentHomePage(),
        DonorOwnDonationsPage(),
        DonorDonationRequestPage(),
        DonorNotificationsPage(),
        DonorProfilePage(),
  ];
}
class AdminBottomBarController extends GetxController {
  var selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> pages = [
      AdminHomePage(),
      AdminMessagesPage(),
      AdminNotificationsPage(),
      AdminProfilePage(),
  ];
}
class AdsaBottomBarController extends GetxController {
  var selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> pages = [
          AdsaHomePage(),
          AdsaMessagesPage(),
          AdsaNotificationsPage(),
          AdsaProfilePage(),
  ];
}