import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:upr_fund_collection/CustomWidgets/Snakbar.dart';

Future<void> storeDonationData({
  required String studentId,
  required String name,
  required String email,
  required double donatedAmount,
  required String semester,
  required String department,
  required String rollNo,
  required String needyPersonName,
}) async {
  try {
    await FirebaseFirestore.instance.collection('StudentDonations').doc(needyPersonName).set({});
    await FirebaseFirestore.instance.collection('StudentDonations').doc(needyPersonName).collection('NeedyPersons').doc(studentId).set({
      'name': name,
      'studentid': studentId,
      'email': email,
      'donated_amount': donatedAmount,
      'needyPersonName': needyPersonName,
      'semester': semester,
      'department': department,
      'roll_no': rollNo,
      'donated_date': FieldValue.serverTimestamp(),
    });
    showSuccessSnackbar('Donation data stored successfully');

    try {
      // Reference to the document in the donation_requests collection
      DocumentReference personRef = FirebaseFirestore.instance.collection('donation_requests').doc('Student').collection('Persons').doc(needyPersonName);

      // Fetch the current amount_received value
      DocumentSnapshot personSnapshot = await personRef.get();
      if (personSnapshot.exists) {
        double currentAmount = personSnapshot['amount_received'] ?? 0.0;
        double newAmount = currentAmount + donatedAmount;
        // Update the amount_received field with the new amount
        await personRef.update({
          'amount_received': newAmount,
        });
      } else {
        await personRef.set({
          'amount_received': donatedAmount,
        });
      }
    } catch (e) {
      showErrorSnackbar(e.toString());
    }
  } catch (e) {
    showErrorSnackbar('Error storing donation data: $e');
  }
}
