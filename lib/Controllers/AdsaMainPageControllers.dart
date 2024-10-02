import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdsaViewDonationModal {
  final String name;
  final String rollNo;
  final String semester;
  final double donatedAmount;

  AdsaViewDonationModal({
    required this.name,
    required this.rollNo,
    required this.semester,
    required this.donatedAmount,
  });

  // Factory method to create an instance from Firestore data
  factory AdsaViewDonationModal.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AdsaViewDonationModal(
      name: data['name'] ?? '',
      rollNo: data['roll_no'] ?? '',
      semester: data['semester'] ?? '',
      donatedAmount: (data['donated_amount'] ?? 0).toDouble(),
    );
  }
}

class AdsaDonationController extends GetxController {
  final donations = <AdsaViewDonationModal>[].obs;

  // Observable for currently selected semester
  var selectedSemester = 'Semester 1'.obs;

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<AdsaViewDonationModal> getDonationsBySemester(String semester) {
    return donations.where((donation) => donation.semester == semester).toList();
  }

  // Fetch documents and sub-documents from Firestore where department == 'computer'
  Future<void> fetchDonations() async {
    try {
      // Clear existing donations
      donations.clear();

      // Fetch the main collection 'StudentDonations'
      final mainCollection = await _firestore.collection('StudentDonations').get();

      for (var doc in mainCollection.docs) {
        // For each document in 'StudentDonations', fetch the 'needy' sub-collection
        final subCollection = await _firestore
            .collection('StudentDonations')
            .doc(doc.id)
            .collection('NeedyPersons')
            .where('department', isEqualTo: 'Computer Science')
            .get();

        // Iterate over the sub-documents and map the data to AdsaViewDonationModal
        for (var subDoc in subCollection.docs) {
          donations.add(AdsaViewDonationModal.fromFirestore(subDoc));
        }
      }
    } catch (e) {
      print("Error fetching donations: $e");
    }
  }

  @override
  void onInit() {
    // Fetch data when the controller is initialized
    fetchDonations();
    super.onInit();
  }
}
