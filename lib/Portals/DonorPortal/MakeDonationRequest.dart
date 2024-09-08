import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/Snakbar.dart';
import 'package:upr_fund_collection/DatabaseDataControllers/DonationRequestAddController.dart';
import 'package:upr_fund_collection/CustomWidgets/ElevatedButton.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';

class DonorsMakeDonationRequest extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final DonationRequestAddController _controller = Get.put(DonationRequestAddController());
  String? _personName;
  String? _reason;
  double? _amountNeeded;
  String? _accountNumber;
  String? _accountHolderName;
  String? _requestBy;
  String? _bankName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(title: 'Add Donation Request', color: Colors.white),
        backgroundColor: Colors.teal.shade700,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add New Donation Request',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField(
                    label: 'Needy Person Name',
                    onChanged: (value) => _personName = value,
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter the name' : null,
                  ),
                  _buildTextField(
                    label: 'Reason',
                    onChanged: (value) => _reason = value,
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter the reason' : null,
                  ),
                  _buildTextField(
                    label: 'Amount Needed',
                    keyboardType: TextInputType.number,
                    onChanged: (value) => _amountNeeded = double.tryParse(value),
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter the amount needed' : null,
                  ),
                  _buildTextField(
                    label: 'Account Number',
                    onChanged: (value) => _accountNumber = value,
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter the account number' : null,
                  ),
                  _buildTextField(
                    label: 'Account Holder Name',
                    onChanged: (value) => _accountHolderName = value,
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter the account holder name' : null,
                  ),
                  _buildDropdown(
                    label: 'Request By',
                    value: _requestBy,
                    items: ['Student', 'OutSider'],
                    onChanged: (value) => _requestBy = value,
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Please select a request by' : null,
                  ),
                  _buildDropdown(
                    label: 'Bank Method',
                    value: _bankName,
                    items: ['Easypaisa', 'JazzCash', 'United Bank Limited', 'Mezan Bank', 'Alflah Bank', 'Askari Bank', 'National Bank', 'Sindh Bank', 'Allied Bank'],
                    onChanged: (value) => _bankName = value,
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Please select a payment method' : null,
                  ),
                  SizedBox(height: 20),
                  Obx((){
                    return  _controller.isloading.value  ? CircularProgressIndicator():
                    Elevated_button(
                        text: 'Submit', color: Colors.white, radius: 10,padding: 10,backcolor: Colors.teal,
                        path: ()async{
                          // DocumentSnapshot<Map<String, dynamic>> Userdata=await FirebaseFirestore.instance.collection('Users').doc(user!.uid).get();
                          if (_formKey.currentState?.validate() ?? false) {
                            await _controller.addDonationRequest(
                              personName: _personName!,
                              reason: _reason!,
                              amountNeeded: _amountNeeded!,
                              accountNumber: _accountNumber!,
                              accountHolderName: _accountHolderName!,
                              request_by: _requestBy!,
                              bank_name: _bankName!,
                              status:'Pending',
                            ).then((value){
                              showSuccessSnackbar('Success Donation request added successfully!');
                              _controller.isloading.value=false;
                              Get.back();
                            });
                          }
                        }
                    );
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required ValueChanged<String> onChanged,
    required FormFieldValidator<String> validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          isDense: true,
        ),
        keyboardType: keyboardType,
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required FormFieldValidator<String?> validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          isDense: true,
        ),
        value: value,
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
