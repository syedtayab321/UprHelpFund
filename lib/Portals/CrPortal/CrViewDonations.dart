import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/Controllers/CrMainController.dart';
import 'package:upr_fund_collection/CustomWidgets/ConfirmDialogBox.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';
import 'package:upr_fund_collection/Models/LoginSharedPrefrencses.dart';

class CrViewDonationPage extends StatefulWidget {
  @override
  _CrViewDonationPageState createState() => _CrViewDonationPageState();
}

class _CrViewDonationPageState extends State<CrViewDonationPage> {
  final AuthService _authService = AuthService();
  final CrMainDonationController controller = Get.put(CrMainDonationController());

  void logout(BuildContext context) async {
    await Get.dialog(
      ConfirmDialog(
        title: 'Logout',
        content: 'Are you sure you want to logout?',
        confirmText: 'Confirm',
        cancelText: 'Cancel',
        onConfirm: () {
          _authService.signOut();
        },
        onCancel: () {
          Get.back();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade800,
        title: TextWidget(
          title: 'Donation Management',
          size: 24,
          weight: FontWeight.bold,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  _buildFilterSection(controller, constraints),
                  SizedBox(height: 20),
                  _buildDonationList(constraints),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterSection(CrMainDonationController controller, BoxConstraints constraints) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          if (constraints.maxWidth > 600)
            Row(
              children: [
                Expanded(child: _buildDropdown('Department', controller.departments, controller.selectedDepartment, controller)),
                SizedBox(width: 20),
                Expanded(child: _buildDropdown('Semester', controller.semesters, controller.selectedSemester, controller)),
              ],
            )
          else
            Column(
              children: [
                _buildDropdown('Department', controller.departments, controller.selectedDepartment, controller),
                SizedBox(height: 20),
                _buildDropdown('Semester', controller.semesters, controller.selectedSemester, controller),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, RxString selectedValue, CrMainDonationController controller) {
    return Obx(() {
      return DropdownButtonFormField<String>(
        value: selectedValue.value,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          selectedValue.value = value!;
          controller.filterDonations();
        },
      );
    });
  }

  Widget _buildDonationList(BoxConstraints constraints) {
    return Obx(() {
      if (controller.filteredDonations.isEmpty) {
        return Center(child: Text('No donations found.'));
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.filteredDonations.length,
        itemBuilder: (context, index) {
          final donation = controller.filteredDonations[index];

          // Extract donation details
          final name = donation['name'] ?? 'N/A';  // Make sure to handle null values
          final rollNo = donation['roll_no'] ?? 'N/A';
          final donatedAmount = donation['donated_amount'] ?? '0';
          final donatedDate = donation['donated_date'] != null
              ? (donation['donated_date'] as Timestamp).toDate().toString()
              : 'N/A';

          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.teal),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Name: $name',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.format_list_numbered, color: Colors.orange),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Roll No: $rollNo',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.monetization_on, color: Colors.green),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Donation Amount: \$${donatedAmount.toString()}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.date_range, color: Colors.blue),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Donated Date: $donatedDate',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

}
