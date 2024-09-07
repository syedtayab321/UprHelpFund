import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/DatabaseDataControllers/ManagingAdsaDataController.dart';
import 'package:upr_fund_collection/CustomWidgets/ElevatedButton.dart';
import 'package:upr_fund_collection/CustomWidgets/Snakbar.dart';

class AdsaForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final formController = Get.put(FormController());
  final String? name,email,department,campus;
  AdsaForm({this.name,this.email,this.department,this.campus});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Adsa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField('Adsa Name',formController.nameController, TextInputType.text),
                SizedBox(height: 16),
                _buildTextField('Adsa Email', formController.EmailController, TextInputType.text),
                SizedBox(height: 16),
                _buildDropdown('Department', formController.departments,
                    formController.selectedDepartment, 'Please select a department'),
                SizedBox(height: 16),
                _buildDropdown('Campus', formController.campuses,
                    formController.selectedCampus, 'Please select a Campus'),
                SizedBox(height: 20),
                Center(
                  child: Obx(() => formController.isloading.value
                      ? CircularProgressIndicator()
                      : Elevated_button(
                    text: 'Add Adsa',
                    color: Colors.white,
                    path: () {
                      if (_formKey.currentState!.validate()) {
                        formController.submitForm();
                      }
                    },
                    radius: 10,
                    padding: 3,
                    backcolor: Colors.blue,
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, TextInputType type) {
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
  var selectedCampus = ''.obs;
  var isloading = false.obs;

  final nameController = TextEditingController();
  final EmailController = TextEditingController();
  final ManagingAdsaDataController _additioncontroller = Get.put(ManagingAdsaDataController());
  final List<String> departments = [
    'Computer Science',
    'Data Science',
    'Software Engineering',
    'Electrical Engineering',
    'Mechanical Engineering',
  ];

  final List<String> campuses = [
        'Basic and Applied Sciences',
        'Cs and IT',
        'Agriculture',
        'Botany',
        'Applied Sciences',
  ];

  void submitForm() async {
    isloading.value = true;
      await  _additioncontroller.addAdsaData(
        AdsaName: nameController.text,
        AdsaEmail:EmailController.text,
        department: selectedDepartment.value,
        campus: selectedCampus.value,
      );
      isloading.value = false;
      showSuccessSnackbar('Cr Data added successfully!');
      Get.back();
  }
}
