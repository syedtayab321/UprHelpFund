import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/ElevatedButton.dart';
import 'package:upr_fund_collection/CustomWidgets/Snakbar.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';
import 'package:intl/intl.dart';
import 'package:upr_fund_collection/DatabaseDataControllers/DonationRequestAddController.dart';

class DonationRequest {
  final String requesterName;
  final String needyPersonName;
  final double neededAmount;
  final String accountHolderName;
  final String accountNumber;
  final String bankName;
  final String reason;
  final DateTime requestDate;
  final String status;

  DonationRequest({
    required this.requesterName,
    required this.needyPersonName,
    required this.neededAmount,
    required this.accountHolderName,
    required this.accountNumber,
    required this.bankName,
    required this.reason,
    required this.requestDate,
    required this.status,
  });

  // Create a factory constructor to instantiate DonationRequest from Firestore DocumentSnapshot
  factory DonationRequest.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return DonationRequest(
      requesterName: data['request_by'] ?? '',
      needyPersonName: data['needyPersonName'],
      neededAmount: data['needed_amount']?.toDouble() ?? 0.0,
      accountHolderName: data['account_holder_name'] ?? '',
      accountNumber: data['account_number'] ?? '',
      bankName: data['bank_name'] ?? '',
      reason: data['reason'] ?? '',
      requestDate: (data['created_at'] as Timestamp).toDate(),
      status: data['status'] ?? '',
    );
  }
}

class DonationRequestsPage extends StatelessWidget {
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
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('donation_requests')
              .where('status', isEqualTo: 'Pending')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No donation requests found.'));
            }

            List<DonationRequest> requests = snapshot.data!.docs
                .map((doc) => DonationRequest.fromFirestore(doc))
                .toList();

            return ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                return DonationRequestCard(request: requests[index]);
              },
            );
          },
        ),
      ),
    );
  }
}

class DonationRequestCard extends StatelessWidget {
  final DonationRequest request;
  final DonationRequestAddController _controller = Get.put(DonationRequestAddController());
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
            _buildInfoRow(Icons.person_outline, 'Needy Person: ', request.needyPersonName),
            _buildInfoRow(Icons.assignment, 'Reason: ', request.reason),
            _buildInfoRow(Icons.person, 'Account Holder Name: ', request.accountHolderName),
            _buildInfoRow(Icons.account_balance_wallet_outlined, 'Account Number: ', request.accountNumber),
            _buildInfoRow(Icons.account_balance_outlined, 'Bank Name: ', request.bankName),
            _buildInfoRow(Icons.monetization_on, 'Needed Amount: ', '\$${request.neededAmount.toStringAsFixed(2)}'),
            _buildInfoRow(Icons.calendar_today, 'Request Date: ',DateFormat('yyyy-MM-dd').format(request.requestDate)),
            _buildInfoRow(Icons.approval, 'Status: ', request.status),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Elevated_button(
                  text: 'Reject',
                  color: Colors.white,
                  path: ()async  {
                    await FirebaseFirestore.instance.collection('donation_requests').doc(request.needyPersonName).delete();
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
                    Obx((){
                      return  _controller.isloading.value  ? CircularProgressIndicator():
                      Elevated_button(
                          text: 'Submit', color: Colors.white, radius: 10,padding: 10,backcolor: Colors.teal,
                          path: ()async{
                              await _controller.addDonationRequest(
                                personName: request.needyPersonName,
                                reason: request.reason,
                                amountNeeded: request.neededAmount,
                                accountNumber: request.accountNumber,
                                accountHolderName: request.accountHolderName,
                                request_by: request.requesterName,
                                bank_name: request.bankName,
                                status: 'Approved',
                              ).then((value){
                                showSuccessSnackbar('Success Donation request added successfully!');
                                _controller.isloading.value=false;
                                Get.back();
                              });
                            }
                      );
                    });
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
