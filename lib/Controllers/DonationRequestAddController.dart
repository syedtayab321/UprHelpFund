import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/Snakbar.dart';

class DonationRequestAddController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addDonationRequest({
    required String personName,
    required String reason,
    required int amountNeeded,
    required String accountNumber,
    required String accountHolderName,
    required String request_by,
    required String bank_name,
  }) async {
    try {
      await _firestore.collection('donation_requests').add({
        'name': personName,
        'reason': reason,
        'needed_amount': amountNeeded,
        'account_number': accountNumber,
        'account_holder_name': accountHolderName,
        'request_by': request_by,
        'bank_name': bank_name,
        'amount_recived': 0,
        'created_at': FieldValue.serverTimestamp(),  // Store the timestamp
      });
      showSuccessSnackbar('Success Donation request added successfully!');
    } catch (e) {
      showErrorSnackbar(e.toString());
    }
  }
}
