import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DonorOwnDonationsPage extends StatefulWidget {
  @override
  _DonorOwnDonationsPageState createState() => _DonorOwnDonationsPageState();
}

class _DonorOwnDonationsPageState extends State<DonorOwnDonationsPage> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('StudentDonations').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No donations found."));
          }

          final studentDonationDocs = snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
              itemCount: studentDonationDocs.length,
              itemBuilder: (context, index) {
                final docId = studentDonationDocs[index].id;

                return StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('StudentDonations')
                      .doc(docId)
                      .collection('NeedyPersons')
                      .doc(user!.uid)
                      .snapshots(),
                  builder: (context, subSnapshot) {
                    if (subSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (!subSnapshot.hasData || !subSnapshot.data!.exists) {
                      return SizedBox.shrink(); // Skip if no matching document found
                    }

                    final donationData = subSnapshot.data!.data() as Map<String, dynamic>;

                    return Card(
                      elevation: 4.0,
                      color: Colors.black,
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Donor: ${donationData['name'] ?? 'Unknown'}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'ID: ${donationData['studentid'] ?? 'N/A'})',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Status: ${donationData['donorStatus'] ?? 'Unknown'}',
                              style: TextStyle(
                                fontSize: 16,
                                color: donationData['donorStatus'] == 'Completed'
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Donation Price: ${donationData['donated_amount'] ?? '0'}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Divider(color: Colors.grey),
                            // Receiver details
                            Text(
                              'Receiver: ${donationData['needyPersonName'] ?? 'Unknown'}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
        },
      ),
    );
  }
}
