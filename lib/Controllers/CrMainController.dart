import 'package:get/get.dart';

class CrMainDonationController extends GetxController {

  final List<String> departments = ['All', 'Computer Science', 'Business', 'Engineering'];
  final List<String> semesters = ['All', '1st Semester', '2nd Semester', '3rd Semester', '4th Semester'];

  var selectedDepartment = 'All'.obs;
  var selectedSemester = 'All'.obs;


  final List<Map<String, String>> donations = [
    {'department': 'Computer Science', 'semester': '1st Semester', 'amount': '\$100'},
    {'department': 'Business', 'semester': '2nd Semester', 'amount': '\$200'},
    {'department': 'Engineering', 'semester': '3rd Semester', 'amount': '\$150'},
  ];

  var filteredDonations = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    filterDonations();
  }

  void filterDonations() {
    filteredDonations.value = donations.where((donation) {
      final matchesDepartment = selectedDepartment.value == 'All' || donation['department'] == selectedDepartment.value;
      final matchesSemester = selectedSemester.value == 'All' || donation['semester'] == selectedSemester.value;
      return matchesDepartment && matchesSemester;
    }).toList();
  }
}