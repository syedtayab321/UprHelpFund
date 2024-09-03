import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/ElevatedButton.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';

class DonationRequest {
  final String requesterType; // E.g., CR, Student, ADSA
  final String requesterName;
  final String needyPersonName;
  final double neededAmount;
  final String accountHolderName;
  final String accountNumber;
  final String bankName;
  final String reason;
  final String requestDate;
  final String status;

  DonationRequest({
    required this.requesterType,
    required this.requesterName,
    required this.needyPersonName,
    required this.neededAmount,
    required this.accountHolderName,
    required this.accountNumber,
    required this.bankName,
    required this.reason,
    required this.requestDate,
    required this.status
  });
}

class DonationRequestsPage extends StatelessWidget {
  final List<DonationRequest> requests = [
    DonationRequest(
      requesterType: 'CR',
      requesterName: 'John Doe',
      needyPersonName: 'Jane Smith',
      neededAmount: 1500.0,
      accountHolderName: 'Wallled',
      accountNumber: '74654563',
      bankName: 'Alfalah Bank',
      reason: 'Medical Assistance',
      requestDate: '2024-08-30',
     status:  'Pending',
    ),
    DonationRequest(
      requesterType: 'Student',
      requesterName: 'Alice Johnson',
      needyPersonName: 'Robert Brown',
      neededAmount: 1200.0,
      accountHolderName: 'Wallled',
      accountNumber: '74654563',
      bankName: 'Alfalah Bank',
      reason: 'Tuition Fee',
      requestDate: '2024-08-29',
      status: 'Pending',
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: requests.length,
          itemBuilder: (context, index) {
            return DonationRequestCard(request: requests[index]);
          },
        ),
      ),
    );
  }
}

class DonationRequestCard extends StatelessWidget {
  final DonationRequest request;

  DonationRequestCard({required this.request});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.teal.shade100,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(Icons.person, 'Requester: ', '${request.requesterType} - ${request.requesterName}'),
            _buildInfoRow(Icons.person_outline, 'Needy Person: ', request.needyPersonName),
            _buildInfoRow(Icons.assignment, 'Reason: ', request.reason),
            _buildInfoRow(Icons.person, 'Account Holder Name: ', request.accountHolderName),
            _buildInfoRow(Icons.account_balance_wallet_outlined, 'Account Number: ', request.accountNumber),
            _buildInfoRow(Icons.account_balance_outlined, 'Bank Name: ', request.bankName),
            _buildInfoRow(Icons.monetization_on, 'Needed Amount: ', '\$${request.neededAmount.toStringAsFixed(2)}'),
            _buildInfoRow(Icons.calendar_today, 'Request Date: ', request.requestDate),
            _buildInfoRow(Icons.approval, 'Status: ', request.status),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Elevated_button(
                  text: 'Reject',
                  color: Colors.white,
                  path: () {
                    // Handle Reject action here
                  },
                  radius: 10,
                  padding: 3,
                  width: 110,
                  height: 40,
                  backcolor: Colors.red,
                ),
                Elevated_button(
                  text: 'Approve',
                  color: Colors.white,
                  path: () {
                    // Handle Approve action here
                  },
                  radius: 10,
                  padding: 3,
                  width: 110,
                  height: 40,
                  backcolor: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal.shade700),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade800,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.teal.shade600),
            ),
          ),
        ],
      ),
    );
  }
}
