import 'package:get/get.dart';
class CrViewDonationModal {
  final String name;
  final String rollNo;
  final String semester;
  final double donatedAmount;

  CrViewDonationModal({
    required this.name,
    required this.rollNo,
    required this.semester,
    required this.donatedAmount,
  });
}

class CrDonationController extends GetxController {
  final donations = <CrViewDonationModal>[].obs;

  // Observable for currently selected semester
  var selectedSemester = 'Semester 1'.obs;

  List<CrViewDonationModal> getDonationsBySemester(String semester) {
    return donations.where((donation) => donation.semester == semester).toList();
  }

  // Add mock data
  @override
  void onInit() {
    donations.assignAll([
      CrViewDonationModal(name: 'John Doe', rollNo: '123', semester: 'Semester 1', donatedAmount: 1000),
      CrViewDonationModal(name: 'Jane Smith', rollNo: '124', semester: 'Semester 2', donatedAmount: 1500),
      CrViewDonationModal(name: 'Mark Lee', rollNo: '125', semester: 'Semester 1', donatedAmount: 2000),
      CrViewDonationModal(name: 'Emily Davis', rollNo: '126', semester: 'Semester 3', donatedAmount: 2500),
    ]);
    super.onInit();
  }
}

