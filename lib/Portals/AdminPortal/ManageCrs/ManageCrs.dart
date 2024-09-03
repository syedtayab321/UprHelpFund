import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/ElevatedButton.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';
import 'package:upr_fund_collection/Portals/AdminPortal/ManageCrs/AddCr.dart';

class ClassReporter {
  final String profilePhoto;
  final String name;
  final String rollNumber;
  final String department;
  final String semester;
  final String session;

  ClassReporter({
    required this.profilePhoto,
    required this.name,
    required this.rollNumber,
    required this.department,
    required this.semester,
    required this.session,
  });
}

class ClassReportersPage extends StatelessWidget {
  final List<ClassReporter> reporters = [
    ClassReporter(
      profilePhoto: 'https://via.placeholder.com/150',
      name: 'John Doe',
      rollNumber: '123456',
      department: 'Computer Science',
      semester: '6th',
      session: '2021-2024',
    ),
    // Add more ClassReporter objects here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(title: 'Class Reporters',color: Colors.white,),
        backgroundColor: Colors.teal.shade700,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Elevated_button(
              text: 'Add CR',
              color: Colors.white,
              path: () {
                Get.to(ClassReporterForm());
              },
              radius: 10,
              padding: 3,
              width: 130,
              height: 40,
              backcolor: Colors.teal.shade900,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: reporters.length,
          itemBuilder: (context, index) {
            return ClassReporterCard(reporter: reporters[index]);
          },
        ),
      ),
    );
  }
}

class ClassReporterCard extends StatelessWidget {
  final ClassReporter reporter;

  ClassReporterCard({required this.reporter});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.teal.shade100,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(reporter.profilePhoto),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      title: reporter.name,
                      size: 18,
                      weight: FontWeight.bold,
                      color: Colors.teal.shade900,
                    ),
                    SizedBox(height: 4),
                    TextWidget(
                      title: reporter.rollNumber,
                      size: 14,
                      color: Colors.teal.shade600,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildInfoRow(Icons.school, 'Department: ', reporter.department),
            _buildInfoRow(Icons.calendar_today, 'Semester: ', reporter.semester),
            _buildInfoRow(Icons.date_range, 'Session: ', reporter.session),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Elevated_button(
                  text: 'Update',
                  color: Colors.white,
                  path: () {},
                  radius: 10,
                  padding: 3,
                  width: 80,
                  height: 40,
                  backcolor: Colors.teal.shade700,
                ),
                Elevated_button(
                  text: 'Delete',
                  color: Colors.white,
                  path: () {},
                  radius: 10,
                  padding: 3,
                  width: 80,
                  height: 40,
                  backcolor: Colors.red.shade600,
                ),
                Elevated_button(
                  text: 'View Donations',
                  color: Colors.white,
                  path: () {},
                  radius: 10,
                  padding: 3,
                  width: 130,
                  height: 40,
                  backcolor: Colors.teal.shade900,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal.shade700),
          SizedBox(width: 8),
          TextWidget(
            title: label,
            weight: FontWeight.bold,
            color: Colors.teal.shade800,
          ),
          Expanded(
            child: TextWidget(
              title: value,
              color: Colors.teal.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
