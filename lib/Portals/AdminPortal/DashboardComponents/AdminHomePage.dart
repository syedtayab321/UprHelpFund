import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/CustomGridBox.dart';
import 'package:upr_fund_collection/Portals/AdminPortal/ManageADSAS/ManageAdsa.dart';
import 'package:upr_fund_collection/Portals/AdminPortal/ManageCrs/ManageCrs.dart';
import 'package:upr_fund_collection/Portals/AdminPortal/ManageDonations/DonationRequests.dart';
import 'package:upr_fund_collection/Portals/AdminPortal/ManageDonations/ManageDonations.dart';
import 'package:upr_fund_collection/Portals/AdminPortal/ManageFeedback/FeedbackPage.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  CustomGridCard(
                      icon: Icons.volunteer_activism_sharp,
                      title: 'Manage Donations',
                      colors: [Colors.green, Colors.blue],
                      onTap: () {
                        Get.to(DonationPage());
                      }
                  ),
                  CustomGridCard(
                      icon: Icons.school,
                      title: 'Manage Class Reporters',
                      colors: [Colors.orange, Colors.black],
                      onTap: () {
                        Get.to(ClassReportersPage());
                      }
                  ),
                  CustomGridCard(
                      icon: Icons.request_page,
                      title: 'Manage Donation Requests',
                      colors: [Colors.black, Colors.blue],
                      onTap: () {
                        Get.to(DonationRequestsPage());
                      }
                  ),
                  CustomGridCard(
                      icon: Icons.people,
                      title: 'Manage ADSAS',
                      colors: [Colors.brown, Colors.blueAccent],
                      onTap: () {
                        Get.to(ADSAdataPage());
                      }
                  ),
                  CustomGridCard(
                      icon: Icons.feedback,
                      title: 'Manage Feedbacks',
                      colors: [Colors.teal, Colors.brown],
                      onTap: () {
                        Get.to(FeedbackPage());
                      }
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade700, Colors.teal.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.shade200,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Admin Dashboard',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Manage all aspects of the platform from here.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
