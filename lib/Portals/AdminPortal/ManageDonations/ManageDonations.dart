import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/DonationCardWidget.dart';
import 'package:upr_fund_collection/CustomWidgets/ElevatedButton.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';
import 'package:upr_fund_collection/Portals/AdminPortal/ManageDonations/AddDonationRequest.dart';
import 'package:upr_fund_collection/Portals/AdminPortal/ManageDonations/ViewDonors.dart';

class DonationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          title: 'Donation Requests',
          color: Colors.white,
        ),
        backgroundColor: Colors.teal.shade700,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Elevated_button(
              text: 'Add Request',
              color: Colors.white,
              path: () {
                Get.to(AddDonationPage());
              },
              radius: 10,
              padding: 3,
              width: 130,
              height: 40,
              backcolor: Colors.blue,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('donation_requests') // Replace with your collection name
              .where('status', isEqualTo: 'Approved') // Filter by status
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No approved donations found.'));
            }

            final approvedDonations = snapshot.data!.docs;

            // Calculate total needed and donated amounts
            double totalNeededAmount = approvedDonations.fold(
              0.0,
                  (sum, doc) => sum + (doc['needed_amount'] ?? 0.0),
            );

            double totalDonatedAmount = approvedDonations.fold(
              0.0,
                  (sum, doc) => sum + (doc['amount_received'] ?? 0.0),
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                 title:  'Total Needed Amount: ${totalNeededAmount.toStringAsFixed(2)}',
                  size: 18,
                    weight: FontWeight.bold,
                ),
                TextWidget(
                 title:  'Total Donated Amount: ${totalDonatedAmount.toStringAsFixed(2)}',
                  size: 18,
                    weight: FontWeight.bold,
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: approvedDonations.length,
                    itemBuilder: (context, index) {
                      final donation = approvedDonations[index];
                      final data = donation.data() as Map<String, dynamic>;

                      return AnimatedOpacity(
                        duration: Duration(milliseconds: 500),
                        opacity: 1,
                        child: DonationCard(
                          personName: data['needyPersonName'] ?? '',
                          reason: data['reason'] ?? '',
                          bank_name: data['bank_name'] ?? '',
                          accountHolderName: data['account_holder_name'] ?? '',
                          accountNumber: data['account_number'] ?? '',
                          requested_by: data['request_by'] ?? '',
                          amountNeeded: data['needed_amount']?.toDouble() ?? 0.0,
                          amountReceived: data['amount_received'].toString(),
                          onDelete: () {
                            // Implement delete functionality
                          },
                          onViewDonors: () {
                            Get.to(AdminViewDonorsPage());
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
