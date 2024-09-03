import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/ElevatedButton.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';
import 'package:upr_fund_collection/Portals/DonorPortal/MakeDonationRequest.dart';

class DonationDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sample data
    final requestId = '23';
    final requestedBy = 'John Doe';
    final profession = 'Teacher';
    final needyName = 'Jane Smith';
    final needyAddress = '123 Elm Street, Springfield';
    final reason = 'Medical emergency';
    final amountNeeded = '150';
    final requestedDate = 'August 30, 2024';

    return Scaffold(
      appBar: AppBar(
        title: TextWidget(title: 'Donation Request Details', color: Colors.white),
        backgroundColor: Colors.teal.shade700,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Requested By: $requestedBy',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade900,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Profession: $profession',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Needy Person:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade800,
                    ),
                  ),
                  Text('Name: $needyName', style: TextStyle(fontSize: 16)),
                  Text('Address: $needyAddress', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 16),
                  Text(
                    'Reason:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade800,
                    ),
                  ),
                  Text(reason, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 16),
                  Text(
                    'Amount Needed: \$${amountNeeded}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Requested Date: $requestedDate',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child:Elevated_button(
                path:(){
                },
                color: Colors.white,
                backcolor: Colors.teal.shade700,
                text: 'Donate',
                radius: 10,
                padding: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
