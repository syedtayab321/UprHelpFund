import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';

class DonorDonationRequestPage extends StatelessWidget {
 User? user=FirebaseAuth.instance.currentUser;

  Stream<List<QueryDocumentSnapshot>> _getDonationRequestsStream() async* {
    // getting current user data
    DocumentSnapshot<Map<String, dynamic>> Userdata=await
    FirebaseFirestore.instance.collection('Users').doc(user!.uid).get();

    final donationRequestsStream =
    FirebaseFirestore.instance.collection('donation_requests').snapshots();

    await for (var snapshot in donationRequestsStream) {
      List<QueryDocumentSnapshot> donationRequests = [];

      for (var doc in snapshot.docs) {
        var subCollectionSnapshot = await doc.reference.collection('Persons').where('request_person_name',isEqualTo:Userdata['name']).get();
        donationRequests.addAll(subCollectionSnapshot.docs);
      }

      yield donationRequests;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Requests'),
      ),
      body: StreamBuilder<List<QueryDocumentSnapshot>>(
        stream: _getDonationRequestsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No donation requests found.'));
          }

          final donationRequests = snapshot.data!;

          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: donationRequests.length,
            itemBuilder: (context, index) {
              final request = donationRequests[index].data() as Map<String, dynamic>;

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                       title:  'Requested By: ${request['request_by']}',
                        size: 18,
                          weight: FontWeight.bold,
                          color: Colors.teal.shade900,
                        ),
                      SizedBox(height: 8),
                      TextWidget(
                        title:  'Needy Person: ${request['needyPersonName']}',
                        size: 18,
                        weight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                      SizedBox(height: 8),
                      TextWidget(
                        title: 'Needed Amount: \$${request['needed_amount']}',
                        size: 16,
                          color: Colors.grey.shade800,
                      ),
                      SizedBox(height: 8),
                      TextWidget(
                        title: 'Status: ${request['status']}',
                        size: 16,
                          weight: FontWeight.bold,
                          color: _getStatusColor(request['status']),
                      ),
                      if (request['status'] == 'Approved') ...[
                        SizedBox(height: 16),
                        TextWidget(
                          title: 'Progress:',
                          size: 16,
                            weight: FontWeight.bold,
                            color: Colors.teal.shade800,
                        ),
                        SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: request['amount_received'].toDouble(),
                          backgroundColor: Colors.teal.shade100,
                          color: Colors.teal.shade700,
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${(request['amount_received'] * 100).toDouble()}% of the goal raised',
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                        ),
                      ],
                      SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red.shade700),
                          onPressed: () {
                            _deleteRequest(donationRequests[index].id);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Function to get the color based on status
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green.shade700;
      case 'Rejected':
        return Colors.red.shade700;
      default:
        return Colors.orange.shade700;
    }
  }

  // Function to delete a donation request (to be implemented)
  void _deleteRequest(String id) {
    FirebaseFirestore.instance.collection('donation_requests').doc(id).delete();
    print('Request with ID $id has been deleted');
  }
}
