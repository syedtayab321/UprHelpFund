import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Import intl for date formatting
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';
import 'package:upr_fund_collection/Portals/StudentPortal/DonationRelatedPages/MakeDonationPage.dart';
import 'package:upr_fund_collection/Portals/StudentPortal/DonationRelatedPages/MakeDonationRequest.dart';

class DonorHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('donation_requests')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No donation requests found.'));
                }

                var mainDocs = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: mainDocs.length,
                  itemBuilder: (context, index) {
                    var mainDoc = mainDocs[index];
                    return SubCollectionDonationRequests(mainDoc.id); // Pass document ID
                  },
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

// Widget to fetch and display sub-collection data
class SubCollectionDonationRequests extends StatelessWidget {
  final String mainDocId;

  SubCollectionDonationRequests(this.mainDocId);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('donation_requests')
          .doc(mainDocId) // Access the main document by ID
          .collection('Persons') // Sub-collection
          .where('status', isEqualTo: 'Approved') // Only fetch 'Approved' requests
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        var subRequests = snapshot.data!.docs;

        return Column(
          children: subRequests.map((doc) {
            var requestData = doc.data() as Map<String, dynamic>;
            return DonationRequestTile(
              needyPersonName: requestData['needyPersonName'] ?? 'Unknown',
              reason: requestData['reason'] ?? 'No reason provided',
              requestedDate: requestData['created_at'], // Keep as Timestamp
              requestData: requestData,
            );
          }).toList(),
        );
      },
    );
  }
}

class DonationRequestTile extends StatelessWidget {
  final String needyPersonName;
  final String reason;
  final Timestamp requestedDate; // Now it's a Timestamp
  final Map<String, dynamic> requestData;

  const DonationRequestTile({
    Key? key,
    required this.needyPersonName,
    required this.reason,
    required this.requestedDate,
    required this.requestData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Convert the Timestamp to DateTime
    DateTime dateTime = requestedDate.toDate();
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime); // Format the date

    return InkWell(
      onTap: () {
        Get.to(MakeDonationPage(), arguments: requestData); // Pass the full request data to the next page
      },
      child: ListTile(
        tileColor: Colors.grey.shade200,
        contentPadding: EdgeInsets.all(16.0),
        leading: Icon(Icons.request_page, color: Colors.teal),
        title: Text(
          needyPersonName,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reason: $reason', style: TextStyle(fontSize: 16)),
            Text('Requested Date: $formattedDate', style: TextStyle(fontSize: 14, color: Colors.grey)), // Display the formatted date
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal),
      ),
    );
  }
}
