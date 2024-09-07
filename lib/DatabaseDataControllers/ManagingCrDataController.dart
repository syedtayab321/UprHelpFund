import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/Snakbar.dart';

class ManagingCrDataController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addCrData({
    required String CrName, required String department,
    required int rollno, required String session, required String semester,
  }) async {
    try {
      String cleanDepartment = department.trim();
      String cleanSession = session.trim();
      String cleanSemester = semester.trim();
      await _firestore.collection('classReporters').doc(cleanDepartment).set({});
      await _firestore.collection('classReporters').doc(cleanDepartment).collection('crs').doc(cleanSemester).set({
        'cr_name': CrName,
        'department': cleanDepartment,
        'roll_no': rollno,
        'session': cleanSession,
        'semester': cleanSemester,
      });
      showSuccessSnackbar('Cr Data added successfully!');
    } catch (e) {
      showErrorSnackbar(e.toString());
    }
  }
  Future<void>DeleteCrData(String department,String semester)async{
    await _firestore.collection('classReporters').doc(department).collection('crs').doc(semester).delete();
  }
}
