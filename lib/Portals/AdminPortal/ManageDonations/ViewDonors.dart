import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';

class AdminViewDonorsPage extends StatelessWidget {
  final String needyPerson;
  AdminViewDonorsPage({required this.needyPerson});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(title: 'Donors', color: Colors.white),
        backgroundColor: Colors.teal.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Firestore Stream to fetch the total donated amount and donor list
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('StudentDonations')
                  .doc(needyPerson)
                  .collection('NeedyPersons')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("No donations found."));
                }

                final donationDocs = snapshot.data!.docs;
                double totalAmount = 0;
                List<Map<String, dynamic>> donorsList = [];

                // Corrected iteration over documents
                for (var subDoc in donationDocs) {
                  var donorData = subDoc.data() as Map<String, dynamic>;
                  totalAmount += donorData['donated_amount'] ?? 0;
                  donorsList.add({
                    'name': donorData['name'] ?? 'Unknown',
                    'amount': donorData['donated_amount'] ?? 0,
                  });
                }

                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display the total donated amount
                      Text(
                        'Total Donated Amount: \$${totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade800,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Display donor list
                      Expanded(
                        child: ListView.builder(
                          itemCount: donorsList.length,
                          itemBuilder: (context, index) {
                            final donor = donorsList[index];
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.teal.shade400,
                                  child: Text(
                                    donor['name'][0], // First letter of the donor's name
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                title: Text(
                                  donor['name'],
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  '\$${donor['amount'].toStringAsFixed(2)} donated',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.teal.shade700),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
