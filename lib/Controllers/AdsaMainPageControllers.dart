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
}

class AdsaDonationController extends GetxController {
  final donations = <AdsaViewDonationModal>[].obs;

  // Observable for currently selected semester
  var selectedSemester = 'Semester 1'.obs;

  List<AdsaViewDonationModal> getDonationsBySemester(String semester) {
    return donations.where((donation) => donation.semester == semester).toList();
  }

  // Add mock data
  @override
  void onInit() {
    donations.assignAll([
      AdsaViewDonationModal(name: 'John Doe', rollNo: '123', semester: 'Semester 1', donatedAmount: 1000),
      AdsaViewDonationModal(name: 'Jane Smith', rollNo: '124', semester: 'Semester 2', donatedAmount: 1500),
      AdsaViewDonationModal(name: 'Mark Lee', rollNo: '125', semester: 'Semester 1', donatedAmount: 2000),
      AdsaViewDonationModal(name: 'Emily Davis', rollNo: '126', semester: 'Semester 3', donatedAmount: 2500),
    ]);
    super.onInit();
  }
}

