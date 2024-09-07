import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/Snakbar.dart';

class DonationRequestAddController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxBool isloading =false.obs;

  Future<void> addDonationRequest({
    required String personName,
    required String reason,
    required double amountNeeded,
    required String accountNumber,
    required String accountHolderName,
    required String request_by,
    required String bank_name,
    required String status,
  }) async {
    isloading.value=true;
    try {
      await _firestore.collection('donation_requests').doc(request_by).set({});
      await _firestore.collection('donation_requests').doc(request_by).collection('Persons').doc(personName).set({
        'needyPersonName': personName,
        'reason': reason,
        'needed_amount': amountNeeded,
        'account_number': accountNumber,
        'account_holder_name': accountHolderName,
        'request_by': request_by,
        'bank_name': bank_name,
        'amount_received': 0,
        'created_at': FieldValue.serverTimestamp(),
        'status':status
      });
      showSuccessSnackbar('Success Donation request added successfully!');
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally{
      Get.back();
    }
  }

  Future<void>DeleteDonationsData(String personName,String request_by)async{
    await _firestore.collection('donation_requests').doc(request_by).collection('Persons').doc(personName).delete();
  }
}
