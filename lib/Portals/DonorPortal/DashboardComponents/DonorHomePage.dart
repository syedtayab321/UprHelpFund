import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';
import 'package:upr_fund_collection/Portals/DonorPortal/DonationRequestDetails.dart';
import 'package:upr_fund_collection/Portals/DonorPortal/MakeDonationRequest.dart';

class DonorHomePage extends StatelessWidget {
  // Dummy data for donation requests
  final List<Map<String, String>> donationRequests = [
    {
      'requestedBy': 'John Doe',
      'profession': 'Student',
      'needyName': 'Jane Smith',
      'needyAddress': '123 Elm Street',
      'reason': 'Medical Emergency',
      'amountNeeded': '500',
      'requestedDate': '2024-08-30', // Added date for demonstration
    },
    {
      'requestedBy': 'Mary Johnson',
      'profession': 'Teacher',
      'needyName': 'Paul Brown',
      'needyAddress': '456 Oak Avenue',
      'reason': 'Educational Support',
      'amountNeeded': '300',
      'requestedDate': '2024-08-29', // Added date for demonstration
    },
    // Add more dummy data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView.builder(
              itemCount: donationRequests.length,
              itemBuilder: (context, index) {
                var requestData = donationRequests[index];
                return DonationRequestTile(
                  requestedBy: requestData['requestedBy'] ?? 'Unknown',
                  reason: requestData['reason'] ?? 'No reason provided',
                  requestedDate: requestData['requestedDate'] ?? 'Unknown date',
                  requestId: 'dummyRequestId_$index',
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.teal.shade700,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            title: 'Welcome to the Donation Hub',
            size: 24,
            weight: FontWeight.bold,
            color: Colors.white,
          ),
          SizedBox(height: 8),
          TextWidget(
            title: 'Browse through the donation requests below and contribute to those in need. You can also make a new donation request if you or someone you know needs support.',
            size: 16,
            color: Colors.white,
          ),
          SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () {
               Get.to(DonorsMakeDonationRequest());
              },
              child: Text('Make a Donation Request'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Background color
                foregroundColor: Colors.teal, // Text color
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DonationRequestTile extends StatelessWidget {
  final String requestedBy;
  final String reason;
  final String requestedDate;
  final String requestId;

  const DonationRequestTile({
    Key? key,
    required this.requestedBy,
    required this.reason,
    required this.requestedDate,
    required this.requestId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(DonationDetailPage());
      },
      child: ListTile(
        tileColor: Colors.grey.shade200,
        contentPadding: EdgeInsets.all(16.0),
        leading: Icon(Icons.request_page, color: Colors.teal),
        title: Text(
          requestedBy,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reason: $reason', style: TextStyle(fontSize: 16)),
            Text('Requested Date: $requestedDate', style: TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.arrow_forward_ios, color: Colors.teal),
          onPressed: () {
            Get.to(DonationDetailPage());
          },
        ),
      ),
    );
  }
}
