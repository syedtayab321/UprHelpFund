import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CrMainDonationController extends GetxController {
  var selectedDepartment = 'Computer Science'.obs;
  var selectedSemester = 'Semester 1'.obs;

  // List of departments and semesters (mock data, you can modify as per your needs)
  final departments = ['Computer Science', 'Mathematics', 'Physics'].obs;
  final semesters = ['Semester 1', 'Semester 2', 'Semester 3','Semester 4', 'Semester 5', 'Semester 6','Semester 7', 'Semester 8'].obs;

  // Observable list to store filtered donations
  final filteredDonations = <Map<String, dynamic>>[].obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> filterDonations() async {
    try {
      // Clear the current donations list
      filteredDonations.clear();

      // Fetch all documents from the Firestore 'StudentDonations' collection
      QuerySnapshot snapshot = await _firestore.collection('StudentDonations').get();

      // Loop through each document in the collection
      for (var doc in snapshot.docs) {
        // Get the main document ID (or other data if needed)
        String docId = doc.id;

        // Access a sub-collection or sub-document within this document
        QuerySnapshot subDocSnapshot = await _firestore
            .collection('StudentDonations')
            .doc(docId) // Reference to the main document
            .collection('NeedyPersons') // Example sub-collection
            .where('department', isEqualTo: selectedDepartment.value)
            .where('semester', isEqualTo: selectedSemester.value)
            .get();

        // Loop through each sub-document within the 'DonationDetails' sub-collection
        for (var subDoc in subDocSnapshot.docs) {
          // Add each sub-document's data to the filteredDonations list
          filteredDonations.add(subDoc.data() as Map<String, dynamic>);
        }
      }
    } catch (e) {
      print("Error fetching donations: $e");
    }
  }


  @override
  void onInit() {
    super.onInit();
    filterDonations(); // Fetch donations when the controller is initialized
  }
}
