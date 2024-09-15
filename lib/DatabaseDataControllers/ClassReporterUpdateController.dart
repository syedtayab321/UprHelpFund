import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/Snakbar.dart';

class CRController extends GetxController {
  var name = ''.obs;
  var rollNo = ''.obs;
  var selectedSession = ''.obs;

  final List<String> sessions = List.generate(41, (index) => '${2020 + index}-${2024 + index}');


  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void loadCRData(String department,String Semester) async {
    try {
      DocumentSnapshot crSnapshot = await firestore.collection('classReporters').doc(department).collection('crs').doc(Semester).get();
      if (crSnapshot.exists) {
        name.value = crSnapshot['cr_name'];
        rollNo.value = crSnapshot['roll_no'];
        selectedSession.value = crSnapshot['session'];
      }
    } catch (e) {
      showErrorSnackbar('Error Unable to fetch data');
    }
  }

  // Update CR data in Firestore
  Future<void> updateCRData(String department,String Semester) async {
    try {
      await firestore.collection('classReporters').doc(department).collection('crs').doc(Semester).update({
        'cr_name': name.value,
        'roll_no': rollNo.value,
        'session': selectedSession.value,
      });
     showSuccessSnackbar('Class Reporter Data Updated Sucessfully ');
    } catch (e) {
      showErrorSnackbar('Error Unable to fetch data');
    }
  }
}
