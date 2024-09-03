import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/Controllers/AddingCrController.dart';
import 'package:upr_fund_collection/CustomWidgets/ElevatedButton.dart';
import 'package:upr_fund_collection/CustomWidgets/Snakbar.dart';

class ClassReporterForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final formController = Get.put(FormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Class Reporter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField('Name', formController.nameController,TextInputType.text),
                SizedBox(height: 16),
                _buildTextField('Roll No', formController.rollNoController,TextInputType.number),
                SizedBox(height: 16),
                _buildDropdown('Department', formController.departments,
                    formController.selectedDepartment, 'Please select a department'),
                SizedBox(height: 16),
                _buildDropdown('Semester', formController.semesters,
                    formController.selectedSemester, 'Please select a semester'),
                SizedBox(height: 16),
                _buildDropdown('Session', formController.sessions,
                    formController.selectedSession, 'Please select a session'),
                SizedBox(height: 20),
                Center(
                  child:Elevated_button(
                    text: 'Add CR',
                    color: Colors.white,
                    path: () {
                      if (_formKey.currentState!.validate()) {
                        formController.submitForm();
                      }
                    },
                    radius: 10,
                    padding: 3,
                    backcolor: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,TextInputType type) {
    return TextFormField(
      keyboardType: type,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  Widget _buildDropdown(String label, List<String> items, RxString selectedItem, String validatorMessage) {
    return Obx(
          () => DropdownButtonFormField<String>(
        value: selectedItem.value.isEmpty ? null : selectedItem.value,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        ))
            .toList(),
        onChanged: (value) {
          selectedItem.value = value!;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validatorMessage;
          }
          return null;
        },
      ),
    );
  }
}

class FormController extends GetxController {
  var selectedDepartment = ''.obs;
  var selectedSemester = ''.obs;
  var selectedSession = ''.obs;
  var isloading = false.obs;

  final nameController = TextEditingController();
  final rollNoController = TextEditingController();
  final CrAddController _additioncontroller = Get.put(CrAddController());
  final List<String> departments = [
    'ComputerScience',
    'InformationTechnology',
    'SoftwareEngineering',
    'ElectricalEngineering',
    'MechanicalEngineering',
  ];

  final List<String> semesters = [
    'First Semester',
    'Second Semester',
    'Third Semester',
    'Fourth Semester',
    'Fifth Semester',
    'Sixth Semester',
    'Seventh Semester',
    'Eighth Semester',
  ];

  final List<String> sessions = List.generate(
      41, (index) => '${2020 + index}-${2024 + index}');

  void submitForm() {
    _additioncontroller.addCrData(
      CrName: nameController.text,
      department: selectedDepartment.toString(),
      rollno: int.parse(rollNoController.text),
      session: selectedSession.toString(),
      semester: selectedSemester.toString(),
    );
  }
}
