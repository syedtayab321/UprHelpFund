import 'package:flutter/material.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';

class AdminViewDonorsPage extends StatelessWidget {
  // Dummy data for donors
  final List<Map<String, dynamic>> donors = [
    {'name': 'John Doe', 'amount': 150},
    {'name': 'Jane Smith', 'amount': 200},
    {'name': 'Alex Johnson', 'amount': 300},
    {'name': 'Emily Davis', 'amount': 100},
    {'name': 'Michael Brown', 'amount': 250},
  ];

  @override
  Widget build(BuildContext context) {
    // Calculate the total donated amount
    final totalAmount = donors.fold(0, (sum, donor) => sum + donor['amount'] as int);

    return Scaffold(
      appBar: AppBar(
        title: TextWidget(title: 'Donors',color:Colors.white),
        backgroundColor: Colors.teal.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the total donated amount
            Text(
              'Total Donated Amount: \$${totalAmount}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
            SizedBox(height: 20),
            // List of donors
            Expanded(
              child: ListView.builder(
                itemCount: donors.length,
                itemBuilder: (context, index) {
                  final donor = donors[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal.shade400,
                        child: Text(
                          donor['name']![0], // First letter of the donor's name
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        donor['name']!,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '\$${donor['amount']} donated',
                        style: TextStyle(fontSize: 16, color: Colors.teal.shade700),
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
