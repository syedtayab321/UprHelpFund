import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/Snakbar.dart';

class ManagingAdsaDataController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addAdsaData({required String AdsaName, required String department, required String AdsaEmail, required String campus}) async {
    try {
      await _firestore.collection('Adsa').doc(campus).set({});
      await _firestore.collection('Adsa').doc(campus).collection('adsa_dep').doc(department).set({
        'adsa_name': AdsaName,
        'adsa_email': AdsaEmail,
        'department':department,
        'Campus': campus,
      });
      showSuccessSnackbar('Adsa Data added successfully!');
    } catch (e) {
      showErrorSnackbar(e.toString());
    }
  }
  Future<void>DeleteAdsaData(String department,String campus)async{
    await _firestore.collection('Adsa').doc(campus).collection('adsa_dep').doc(department).delete();
  }
}
