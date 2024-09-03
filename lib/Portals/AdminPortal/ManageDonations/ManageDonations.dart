import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/DonationCardWidget.dart';
import 'package:upr_fund_collection/CustomWidgets/ElevatedButton.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';
import 'package:upr_fund_collection/Portals/AdminPortal/ManageDonations/AddDonationRequest.dart';
import 'package:upr_fund_collection/Portals/AdminPortal/ManageDonations/ViewDonors.dart';

class DonationPage extends StatelessWidget {
  final List<DonationRequest> dummyDonations = [
    DonationRequest(
      name: 'Jane Smith',
      reason: 'Medical Assistance',
      bankName: 'Bank of Example',
      accountHolderName: 'Jane Smith',
      accountNumber: '1234567890',
      requestedBy: 'Admin',
      neededAmount: 1500.0,
      amountReceived: 'Pending',
    ),
    DonationRequest(
      name: 'John Doe',
      reason: 'Educational Support',
      bankName: 'Example Bank',
      accountHolderName: 'John Doe',
      accountNumber: '0987654321',
      requestedBy: 'Admin',
      neededAmount: 1000.0,
      amountReceived: 'Approved',
    ),
    // Add more DonationRequest objects here
  ];

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
        child: ListView.builder(
          itemCount: dummyDonations.length,
          itemBuilder: (context, index) {
            final donation = dummyDonations[index];

            return AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: 1,
              child: DonationCard(
                personName: donation.name,
                reason: donation.reason,
                bank_name: donation.bankName,
                accountHolderName: donation.accountHolderName,
                accountNumber: donation.accountNumber,
                requested_by: donation.requestedBy,
                amountNeeded: donation.neededAmount,
                amountReceived: donation.amountReceived,
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
    );
  }
}

class DonationRequest {
  final String name;
  final String reason;
  final String bankName;
  final String accountHolderName;
  final String accountNumber;
  final String requestedBy;
  final double neededAmount;
  final String amountReceived;

  DonationRequest({
    required this.name,
    required this.reason,
    required this.bankName,
    required this.accountHolderName,
    required this.accountNumber,
    required this.requestedBy,
    required this.neededAmount,
    required this.amountReceived,
  });
}

class DonationCard extends StatelessWidget {
  final String personName;
  final String reason;
  final String bank_name;
  final String accountHolderName;
  final String accountNumber;
  final String requested_by;
  final double amountNeeded;
  final String amountReceived;
  final VoidCallback onDelete;
  final VoidCallback onViewDonors;

  DonationCard({
    required this.personName,
    required this.reason,
    required this.bank_name,
    required this.accountHolderName,
    required this.accountNumber,
    required this.requested_by,
    required this.amountNeeded,
    required this.amountReceived,
    required this.onDelete,
    required this.onViewDonors,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      margin: EdgeInsets.symmetric(vertical: 10),
      shadowColor: Colors.teal.shade100,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade600, Colors.teal.shade800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.person, size: 40, color: Colors.white),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        personName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Requested By: $requested_by',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              _buildInfoRow(Icons.assignment, 'Reason: ', reason),
              _buildInfoRow(Icons.account_balance, 'Bank Name: ', bank_name),
              _buildInfoRow(Icons.person, 'Account Holder Name: ', accountHolderName),
              _buildInfoRow(Icons.account_balance_wallet, 'Account Number: ', accountNumber),
              _buildInfoRow(Icons.monetization_on, 'Needed Amount: ', '\$$amountNeeded'),
              _buildInfoRow(Icons.attach_money, 'Status: ', amountReceived),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Elevated_button(
                    text: 'Delete',
                    color: Colors.white,
                    path: onDelete,
                    radius: 10,
                    padding: 3,
                    width: 110,
                    height: 40,
                    backcolor: Colors.red,
                  ),
                  Elevated_button(
                    text: 'View Donors',
                    color: Colors.white,
                    path: onViewDonors,
                    radius: 10,
                    padding: 3,
                    width: 110,
                    height: 40,
                    backcolor: Colors.blue,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
