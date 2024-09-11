import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/Snakbar.dart';

class CRController extends GetxController {
  var name = ''.obs;
  var rollNo = ''.obs;
  var selectedSemester = ''.obs;
  var selectedSession = ''.obs;
  var selectedDepartment = ''.obs;

  final List<String> semesters = ['First Semester', 'Second Semester', 'Third Semester', 'Fourth Semester',
    'Fifth Semester', 'Sixth Semester', 'Seventh Semester', 'Eighth Semester'];
  final List<String> sessions = List.generate(41, (index) => '${2020 + index}-${2024 + index}');
  final List<String> departments = ['Computer Science', 'Data Science', 'Software Engineering',
    'Electrical Engineering', 'Mechanical Engineering',];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void loadCRData(String department,String Semester) async {
    try {
      DocumentSnapshot crSnapshot = await firestore.collection('classReporters').doc(department).collection('crs').doc(Semester).get();
      if (crSnapshot.exists) {
        name.value = crSnapshot['cr_name'];
        rollNo.value = crSnapshot['roll_no'];
        selectedSemester.value = crSnapshot['semester'];
        selectedSession.value = crSnapshot['session'];
        selectedDepartment.value = crSnapshot['department'];
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
        'semester': selectedSemester.value,
        'session': selectedSession.value,
        'department': selectedDepartment.value,
      });
      Get.snackbar("Success", "CR data updated successfully!");
    } catch (e) {
      showErrorSnackbar('Error Unable to fetch data');
    }
  }
}
