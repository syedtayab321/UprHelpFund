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
        title: TextWidget(title: 'Donation Management',
          size: 24, weight: FontWeight.bold,color: Colors.white,),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade700,
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: Icon(Icons.add, size: 24),
                    label: TextWidget(title: 'Add Donation', size: 18,color: Colors.white,),
                    onPressed: () {
                      // Navigate to Add Donation Page
                    },
                  ),

                  SizedBox(height: 30),

                  // Filters for viewing donations with responsive design
                  _buildFilterSection(controller, constraints),

                  SizedBox(height: 20),

                  // Filtered Donations List with better styling
                  _buildDonationList(constraints),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Build Filter Section with a responsive design
  Widget _buildFilterSection(CrMainDonationController controller, BoxConstraints constraints) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          if (constraints.maxWidth > 600) // For wider screens, use row layout
            Row(
              children: [
                Expanded(child: _buildDropdown('Department', controller.departments, controller.selectedDepartment, controller)),
                SizedBox(width: 20),
                Expanded(child: _buildDropdown('Semester', controller.semesters, controller.selectedSemester, controller)),
              ],
            )
          else // For smaller screens, use column layout
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

  // Build Dropdown Widget
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

  // Build Donation List with responsive layout
  Widget _buildDonationList(BoxConstraints constraints) {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.filteredDonations.length,
        itemBuilder: (context, index) {
          final donation = controller.filteredDonations[index];
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(Icons.monetization_on, color: Colors.green),
              title: Text('${donation['department']} - ${donation['semester']}'),
              subtitle: Text('Donation Amount: ${donation['amount']}'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
          );
        },
      );
    });
  }
}
