import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/ElevatedButton.dart';
import 'package:upr_fund_collection/DatabaseDataControllers/ClassReporterUpdateController.dart';

class CRUpdateForm extends StatelessWidget {
  final String Department,Semester;
  final CRController crController = Get.put(CRController());

  CRUpdateForm({required this.Department,required this.Semester}) {
    crController.loadCRData(Department,Semester);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update CR Data')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              // Name Text Field
              Obx(() => TextFormField(
                initialValue: crController.name.value,
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) => crController.name.value = value,
              )),
              SizedBox(height: 16),

              // Roll No Text Field
              Obx(() => TextFormField(
                initialValue: crController.rollNo.value,
                decoration: InputDecoration(labelText: 'Roll No'),
                onChanged: (value) => crController.rollNo.value = value,
              )),
              SizedBox(height: 16),

              // Semester Dropdown
              Obx(() => DropdownButtonFormField<String>(
                value: crController.selectedSemester.value.isNotEmpty
                    ? crController.selectedSemester.value
                    : null,
                decoration: InputDecoration(labelText: 'Select Semester'),
                items: crController.semesters.map((String semester) {
                  return DropdownMenuItem<String>(
                    value: semester,
                    child: Text(semester),
                  );
                }).toList(),
                onChanged: (newValue) {
                  crController.selectedSemester.value = newValue!;
                },
              )),
              SizedBox(height: 16),

              // Session Dropdown
              Obx(() => DropdownButtonFormField<String>(
                value: crController.selectedSession.value.isNotEmpty
                    ? crController.selectedSession.value
                    : null,
                decoration: InputDecoration(labelText: 'Select Session'),
                items: crController.sessions.map((String session) {
                  return DropdownMenuItem<String>(
                    value: session,
                    child: Text(session),
                  );
                }).toList(),
                onChanged: (newValue) {
                  crController.selectedSession.value = newValue!;
                },
              )),
              SizedBox(height: 16),

              // Department Dropdown
              Obx(() => DropdownButtonFormField<String>(
                value: crController.selectedDepartment.value.isNotEmpty
                    ? crController.selectedDepartment.value
                    : null,
                decoration: InputDecoration(labelText: 'Select Department'),
                items: crController.departments.map((String department) {
                  return DropdownMenuItem<String>(
                    value: department,
                    child: Text(department),
                  );
                }).toList(),
                onChanged: (newValue) {
                  crController.selectedDepartment.value = newValue!;
                },
              )),
              SizedBox(height: 32),
              Elevated_button(
                  text: 'Update',
                  color: Colors.white,
                  path: (){
                    crController.updateCRData(Department,Semester);
                  },
                 backcolor: Colors.teal.shade800,
                 padding: 10,
                 radius: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
