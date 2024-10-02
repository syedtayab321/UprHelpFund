import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:upr_fund_collection/Controllers/CrMainController.dart';
import 'package:upr_fund_collection/CustomWidgets/ConfirmDialogBox.dart';
import 'package:upr_fund_collection/CustomWidgets/ElevatedButton.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';
import 'package:upr_fund_collection/Models/LoginSharedPrefrencses.dart';
import 'package:upr_fund_collection/PaymentRelated/PaymentFormPage.dart';
import 'package:upr_fund_collection/Portals/CrPortal/CrViewDonations.dart';

class CrHomePage extends StatefulWidget {
  @override
  _CrHomePageState createState() => _CrHomePageState();
}

class _CrHomePageState extends State<CrHomePage> {
  final AuthService _authService = AuthService();
  final CrMainDonationController controller = Get.put(CrMainDonationController());

  void logout(BuildContext context) async {
    await Get.dialog(
      ConfirmDialog(
        title: 'Logout',
        content: 'Are you sure you want to logout?',
        confirmText: 'Confirm',
        cancelText: 'Cancel',
        onConfirm: () {
          _authService.signOut();
        },
        onCancel: () {
          Get.back();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(title: 'CR Home Page', color: Colors.white),
        backgroundColor: Colors.teal.shade800,
        actions: [
          Elevated_button(
            text: 'Logout',
            color: Colors.white,
            path: () {
              logout(context);
            },
            radius: 10,
            padding: 3,
            width: 130,
            height: 40,
            backcolor: Colors.red.shade800,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Management Section
            GestureDetector(
              onTap: () {
                Get.to(() => CrViewDonationPage());
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.teal, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.manage_accounts, color: Colors.teal.shade800),
                    TextWidget(
                      title: 'Manage Donations',
                      size: 18,
                      color: Colors.teal,
                      weight: FontWeight.bold,
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.teal.shade800),
                  ],
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('donation_requests').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No donation requests available.'));
                  }
                  var mainDocs = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: mainDocs.length,
                    itemBuilder: (context, index) {
                      var mainDoc = mainDocs[index];
                      return StreamBuilder<QuerySnapshot>(
                        stream:  FirebaseFirestore.instance
                            .collection('donation_requests')
                            .doc(mainDoc.id)
                            .collection('Persons')
                            .where('status', isEqualTo: 'Approved')
                            .snapshots(),
                        builder: (context, subSnapshot) {
                          if (subSnapshot.connectionState == ConnectionState.waiting) {
                            return Container();
                          }
                          if (!subSnapshot.hasData || subSnapshot.data!.docs.isEmpty) {
                            return Center(child: TextWidget(title: 'No Requests Found'),);
                          }
                          var subRequests = subSnapshot.data!.docs;
                          return Column(
                            children: subRequests.map((doc) {
                              var requestData = doc.data() as Map<String, dynamic>;
                              print(subRequests.length);
                              print (requestData.length);
                              return DonationRequestTile(
                                needyPersonName: requestData['needyPersonName'] ?? 'Unknown',
                                reason: requestData['reason'] ?? 'No reason provided',
                                requestedDate: requestData['created_at'],
                                amount: requestData['needed_amount'],
                              );
                            }).toList(),
                          );

                        },
                      );
                    },
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
class DonationRequestTile extends StatelessWidget {
  final String needyPersonName;
  final String reason;
  final Timestamp requestedDate;
  final double amount;

  const DonationRequestTile({
    Key? key,
    required this.needyPersonName,
    required this.reason,
    required this.requestedDate,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = requestedDate.toDate();
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime); // Format the date
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              title: reason,
              size: 18,
              weight: FontWeight.bold,
            ),
            SizedBox(height: 10),
            TextWidget(
              title: 'Name: $needyPersonName',
              size: 16,
            ),
            SizedBox(height: 10),
            TextWidget(
              title: 'Donation Amount: \$${amount}',
              size: 16,
              color: Colors.green,
            ),
            SizedBox(height: 20),
            TextWidget(title: 'Requested Date: $formattedDate',
                size: 14, color: Colors.grey),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  Get.to(() => PaymentPage(needyPersonName: needyPersonName,));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.teal.shade800, width: 2),
                  ),
                  child: TextWidget(
                    title: 'Donate',
                    color: Colors.teal.shade800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
