import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/Snakbar.dart';

class CrAddController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addCrData({
    required String CrName,
    required String department,
    required int rollno,
    required String session,
    required String semester,
  }) async {
    try {
      await _firestore.collection('class_reporters').add({
        'cr_name':CrName,
        'department':department,
        'roll_no':rollno,
        'session':session,
        'semester':semester
      });
      showSuccessSnackbar('Cr Data added sucessfully!');
      Get.back();
    } catch (e) {
      showErrorSnackbar(e.toString());
    }
  }
}
