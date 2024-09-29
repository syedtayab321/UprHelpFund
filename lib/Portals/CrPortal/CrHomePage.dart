import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/Controllers/CrMainController.dart';
import 'package:upr_fund_collection/CustomWidgets/ConfirmDialogBox.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';
import 'package:upr_fund_collection/Models/LoginSharedPrefrencses.dart';
import 'package:upr_fund_collection/Portals/CrPortal/CrPayment.dart';
import 'package:upr_fund_collection/Portals/CrPortal/CrViewDonations.dart';

class CrHomePage extends StatefulWidget {
  @override
  _CrHomePageState createState() => _CrHomePageState();
}

class _CrHomePageState extends State<CrHomePage> {
  final AuthService _authService = AuthService();
  final CrMainDonationController controller = Get.put(CrMainDonationController());

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

  final List<Map<String, dynamic>> donationRequests = [
    {
      'name': 'John Doe',
      'title': 'Help for Education',
      'amount': 500,
    },
    {
      'name': 'Jane Smith',
      'title': 'Medical Support',
      'amount': 1000,
    },
    // Add more donation requests here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(title: 'CR Home Page',color: Colors.white,),
        backgroundColor: Colors.teal.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Management Section
            GestureDetector(
              onTap: () {
                Get.to(() => CrViewDonationPage());
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.teal, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.manage_accounts, color: Colors.teal.shade800),
                    TextWidget(
                      title: 'Manage Donations',
                      size: 18,
                        color: Colors.teal,
                        weight: FontWeight.bold,
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.teal.shade800),
                  ],
                ),
              ),
            ),

            // Donation Requests List
            Expanded(
              child: ListView.builder(
                itemCount: donationRequests.length,
                itemBuilder: (context, index) {
                  final donation = donationRequests[index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                           title:donation['title'],
                            size: 18,
                             weight: FontWeight.bold,
                            ),
                          SizedBox(height: 10),
                          TextWidget(
                           title:  'Name: ${donation['name']}',
                            size: 16),
                          SizedBox(height: 10),
                          TextWidget(
                           title:  'Donation Amount: \$${donation['amount']}',
                            size: 16, color: Colors.green,
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => PaymentPage());
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 40,right: 40,top: 10,bottom: 10),
                                decoration: BoxDecoration(
                                  color: Colors.teal.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.teal.shade800, width: 2),
                                ),
                                child: TextWidget(
                                 title:  'Donate',
                                 color: Colors.teal.shade800),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
