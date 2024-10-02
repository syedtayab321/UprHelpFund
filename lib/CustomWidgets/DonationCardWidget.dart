import 'package:flutter/material.dart';
import 'package:upr_fund_collection/CustomWidgets/ElevatedButton.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';

class DonationCard extends StatelessWidget {
  final String personName;
  final String reason;
  final double amountNeeded;
  final String amountReceived;
  final String accountNumber;
  final String accountHolderName;
  final String requested_by;
  final String bank_name;
  final VoidCallback onDelete;
  final VoidCallback onViewDonors;

  const DonationCard({
    Key? key,
    required this.personName,
    required this.reason,
    required this.amountNeeded,
    required this.amountReceived,
    required this.accountHolderName,
    required this.accountNumber,
    required this.bank_name,
    required this.requested_by,
    required this.onDelete,
    required this.onViewDonors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                    title: 'Name:',
                    size: 18, weight: FontWeight.bold, color: Colors.white),
                TextWidget(
                    title: personName,
                    size: 18, weight: FontWeight.bold, color: Colors.white),
              ],
            ),
            SizedBox(height: 8),
            Divider(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  title:  'Account Number:',
                  size: 16, color: Colors.white,
                ),
                TextWidget(
                  title:  '$accountNumber',
                  size: 16, color: Colors.white,
                ),
              ],
            ),
            SizedBox(height: 8),
            Divider(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                    title: 'Reason:',
                    size: 16, color: Colors.white
                ),
                TextWidget(
                    title: '$reason',
                    size: 16, color: Colors.white
                ),
              ],
            ),
            SizedBox(height: 8),
            Divider(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                    title: 'Account Holder Name:',
                    size: 18, color: Colors.white),
                TextWidget(
                    title: '$accountHolderName',
                    size: 18, color: Colors.white),
              ],
            ),
            SizedBox(height: 8),
            Divider(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                    title: 'Bank Name:',
                    size: 18, color: Colors.white),
                TextWidget(
                    title: '$bank_name',
                    size: 18, color: Colors.white),
              ],
            ),
            SizedBox(height: 8),
            Divider(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                    title: 'Requested By:',
                    size: 18, color: Colors.white),
                TextWidget(
                    title: '$requested_by',
                    size: 18, color: Colors.white),
              ],
            ),
            SizedBox(height: 8),
            Divider(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  title:  'Amount Needed:',
                  size: 16, color: Colors.white,
                ),
                TextWidget(
                  title:  '${amountNeeded.toString()}',
                  size: 16, color: Colors.green,
                ),
              ],
            ),
            SizedBox(height: 8),
            Divider(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  title: 'Amount Received:',
                  size: 16, color: Colors.white,
                ),
                TextWidget(
                  title: '${amountReceived.toString()}',
                  size: 16, color: Colors.white,
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Elevated_button(
                  text: 'Delete',
                  color: Colors.white,
                  path:onDelete,
                  radius: 10,
                  padding: 3,
                  width: 100,
                  height: 40,
                  backcolor: Colors.red,
                ),
                Elevated_button(
                  text: 'View Donors',
                  color: Colors.white,
                  path: onViewDonors,
                  radius: 10,
                  padding: 3,
                  width: 140,
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
}