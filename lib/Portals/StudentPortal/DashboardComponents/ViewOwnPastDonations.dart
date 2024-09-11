import 'package:flutter/material.dart';


class DonorOwnDonationsPage extends StatelessWidget {
  // Sample data for past donations
  final List<Map<String, String>> donations = [
    {
      'donorName': 'John Doe',
      'donorId': 'D001',
      'donorStatus': 'Completed',
      'donationPrice': '\$100',
      'receiverName': 'Jane Smith',
      'receiverId': 'R001',
      'receiverReason': 'Medical Expenses',
    },
    {
      'donorName': 'Alice Johnson',
      'donorId': 'D002',
      'donorStatus': 'Completed',
      'donationPrice': '\$250',
      'receiverName': 'Bob Brown',
      'receiverId': 'R002',
      'receiverReason': 'School Fees',
    },
    // Add more donation records here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: donations.length,
          itemBuilder: (context, index) {
            final donation = donations[index];
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
                      'Donor: ${donation['donorName']} (ID: ${donation['donorId']})',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Status: ${donation['donorStatus']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: donation['donorStatus'] == 'Completed'
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Donation Price: ${donation['donationPrice']}',
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
                      'Receiver: ${donation['receiverName']} (ID: ${donation['receiverId']})',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Reason for Need: ${donation['receiverReason']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
