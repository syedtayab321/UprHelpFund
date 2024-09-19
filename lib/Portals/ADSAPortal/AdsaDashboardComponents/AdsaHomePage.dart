import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/Controllers/AdsaMainController.dart';

class AdsaHomePage extends StatefulWidget {
  @override
  State<AdsaHomePage> createState() => _AdsaHomePageState();
}

class _AdsaHomePageState extends State<AdsaHomePage> {
  final AdsaDonationController donationController = Get.put(AdsaDonationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // GridView of options
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  _buildMenuOption(
                    context: context,
                    icon: Icons.view_agenda,
                    label: 'View Donations',
                    onTap: () {
                      // Navigate to Manage Views page
                    },
                  ),
                  _buildMenuOption(
                    context: context,
                    icon: Icons.person,
                    label: 'View Donation Requests',
                    onTap: () {
                      // Navigate to User Management page
                    },
                  ),
                  _buildMenuOption(
                    context: context,
                    icon: Icons.notifications,
                    label: 'Notifications',
                    onTap: () {
                      // Navigate to Notifications page
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildMenuOption({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 4.0,
        color: Colors.blueAccent,
        shadowColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: Colors.white,
              ),
              SizedBox(height: 16.0),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
