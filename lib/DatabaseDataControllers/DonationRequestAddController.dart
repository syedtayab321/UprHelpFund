import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/Snakbar.dart';

class DonationRequestAddController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxBool isloading =false.obs;
  double amountRecived=0.0;
  Future<void> addDonationRequest({
    required String personName,
    required String reason,
    required double amountNeeded,
    required String accountNumber,
    required String accountHolderName,
    final String? requested_person_name,
    required String requested_person_profession,
    final String? requested_person_semester,
    final String? requested_person_department,
    required String bank_name,
    required String status,
  }) async {
    isloading.value=true;
    try {
      await _firestore.collection('donation_requests').doc(requested_person_profession).set({});
      await _firestore.collection('donation_requests').doc(requested_person_profession).collection('Persons').doc(personName).set({
        'needyPersonName': personName,
        'reason': reason,
        'needed_amount': amountNeeded,
        'account_number': accountNumber,
        'account_holder_name': accountHolderName,
        'request_person_name': requested_person_name,
        'request_person_profession': requested_person_profession,
        'request_person_semester': requested_person_semester,
        'department': requested_person_department,
        'bank_name': bank_name,
        'amount_received': amountRecived,
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

  Future<void>DeleteDonationsData(String personName,String requested_person_profession)async{
    await _firestore.collection('donation_requests').doc(requested_person_profession).collection('Persons').doc(personName).delete();
  }
}
