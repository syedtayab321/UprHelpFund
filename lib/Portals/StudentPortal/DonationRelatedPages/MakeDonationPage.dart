import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/ElevatedButton.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';
import 'package:upr_fund_collection/PaymentRelated/CrPayment.dart';
import 'package:upr_fund_collection/Portals/StudentPortal/PaymentRelatedPages/PaymentMethodSelector.dart';

class MakeDonationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the passed arguments (request data)
    final requestData = Get.arguments as Map<String, dynamic>;

    // Extract the data from the passed arguments
    final requestedBy = requestData['request_person_name'] ?? 'N/A';
    final requestedPersonProfession = requestData['request_person_profession'] ?? 'N/A';
    final needyName = requestData['needyPersonName'] ?? 'N/A';
    final DonatedAmount= requestData['amount_received'] ?? 'N/A';
    final reason = requestData['reason'] ?? 'N/A';
    final amountNeeded = requestData['needed_amount'] ?? 'N/A';
    final Timestamp requestedDate = requestData['created_at'] ?? 'N/A';

    DateTime dateTime = requestedDate.toDate();
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

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
                  TextWidget(
                    title: 'Requested By: $requestedBy',
                    size: 20,
                      weight: FontWeight.bold,
                      color: Colors.teal.shade900,
                    ),
                  SizedBox(height: 16),
                  TextWidget(
                    title: 'Profession: $requestedPersonProfession',
                    size: 20,
                    color: Colors.teal.shade900,
                  ),
                  SizedBox(height: 16),
                  TextWidget(
                    title: 'Needy Person:',
                    size: 18,
                     weight: FontWeight.bold,
                      color: Colors.teal.shade800,
                  ),
                  TextWidget(title: 'Name: $needyName', size: 16),
                  SizedBox(height: 16),
                  TextWidget(
                    title:'Reason:',
                    size: 18,
                      weight: FontWeight.bold,
                      color: Colors.teal.shade800,
                  ),
                  TextWidget(title: reason, size: 16),
                  SizedBox(height: 16),
                  TextWidget(
                    title: 'Amount Needed: \$${amountNeeded}',
                    size: 18,
                      color: Colors.red.shade700,
                      weight: FontWeight.bold,
                  ),
                  TextWidget(
                   title:  'Amount Recived: \$${DonatedAmount}',
                    size: 18,
                      color: Colors.green,
                      weight: FontWeight.bold,
                  ),
                  SizedBox(height: 16),
                  TextWidget(
                   title:  'Requested Date: $formattedDate',
                    size: 16,
                      color: Colors.grey.shade600,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Elevated_button(
                path: () {
                 // Get.to(PaymentMethodSelector());
                 Get.to(PaymentPage());
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
