import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/ElevatedButton.dart';
import 'package:upr_fund_collection/CustomWidgets/Snakbar.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';
import 'package:upr_fund_collection/PaymentRelated/DonationDatabaseStore.dart';

class PaymentController extends GetxController {
  var selectedPaymentMethod = 'EasyPaisa'.obs;
}

class PaymentPage extends StatelessWidget {
  final String needyPersonName;
  PaymentPage({required this.needyPersonName,});
  final PaymentController controller = Get.put(PaymentController());
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardExpiryController = TextEditingController();
  final TextEditingController cardCvcController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Payment methods list
  final List<String> paymentMethods = [
    'EasyPaisa',
    'JazzCash',
    'Credit Card',
    'Pay by Hand',
  ];

  // Function to format card number input
  String formatCardNumber(String value) {
    value = value.replaceAll(RegExp(r'\s+\b|\b\s'), ''); // Remove spaces
    final StringBuffer formatted = StringBuffer();
    for (int i = 0; i < value.length; i++) {
      if (i != 0 && i % 4 == 0) {
        formatted.write(' '); // Add space every 4 digits
      }
      formatted.write(value[i]);
    }
    return formatted.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(title: 'Make Payment', color: Colors.white),
        backgroundColor: Colors.teal.shade800,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Payment Method Dropdown
                        TextWidget(
                            title: 'Select Payment Method',
                            size: 16,
                            weight: FontWeight.bold),
                        SizedBox(height: 10),
                        Obx(() => DropdownButtonFormField<String>(
                              value: controller.selectedPaymentMethod.value,
                              items: paymentMethods.map((String method) {
                                return DropdownMenuItem<String>(
                                  value: method,
                                  child: Text(method),
                                );
                              }).toList(),
                              onChanged: (value) {
                                controller.selectedPaymentMethod.value = value!;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                              ),
                            )),
                        SizedBox(height: 20),

                        // Conditional Fields based on Payment Method
                        Obx(() {
                          switch (controller.selectedPaymentMethod.value) {
                            case 'EasyPaisa':
                            case 'JazzCash':
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                      title: 'Mobile Number',
                                      size: 16,
                                      weight: FontWeight.bold),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    controller: mobileController,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter your mobile number',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a mobile number';
                                      } else if (!RegExp(r'^\d{10}$')
                                          .hasMatch(value)) {
                                        return 'Enter a valid mobile number (10 digits)';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  TextWidget(
                                      title: 'Amount',
                                      size: 16,
                                      weight: FontWeight.bold),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    controller: amountController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter the amount',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter an amount';
                                      } else if (double.tryParse(value) ==
                                          null) {
                                        return 'Enter a valid amount';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              );
                            case 'Credit Card':
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                      title: 'Card Number',
                                      size: 16,
                                      weight: FontWeight.bold),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    controller: cardNumberController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter card number',
                                    ),
                                    maxLength: 19, // 16 digits + 3 spaces
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      TextInputFormatter.withFunction(
                                          (oldValue, newValue) {
                                        return TextEditingValue(
                                          text: formatCardNumber(newValue.text),
                                          selection: TextSelection.fromPosition(
                                            TextPosition(
                                                offset: formatCardNumber(
                                                        newValue.text)
                                                    .length),
                                          ),
                                        );
                                      }),
                                    ],
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your card number';
                                      } else if (value
                                              .replaceAll(' ', '')
                                              .length !=
                                          16) {
                                        return 'Enter a valid card number (16 digits)';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: cardExpiryController,
                                          keyboardType: TextInputType.datetime,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'MM/YY',
                                            labelText: 'Expiry Date',
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter expiry date';
                                            } else if (!RegExp(
                                                    r'^(0[1-9]|1[0-2])\/?([0-9]{2})$')
                                                .hasMatch(value)) {
                                              return 'Enter a valid expiry date (MM/YY)';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: TextFormField(
                                          controller: cardCvcController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'CVC',
                                            labelText: 'CVC',
                                          ),
                                          maxLength: 3,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter CVC';
                                            } else if (value.length != 3) {
                                              return 'Enter a valid CVC (3 digits)';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  TextWidget(
                                      title: 'Amount',
                                      size: 16,
                                      weight: FontWeight.bold),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    controller: amountController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter the amount',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter an amount';
                                      } else if (double.tryParse(value) ==
                                          null) {
                                        return 'Enter a valid amount';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              );
                            case 'Pay by Hand':
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  TextWidget(
                                      title: 'Amount',
                                      size: 16,
                                      weight: FontWeight.bold),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    controller: amountController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter the amount',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter an amount';
                                      } else if (double.tryParse(value) ==
                                          null) {
                                        return 'Enter a valid amount';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              );
                            default:
                              return SizedBox();
                          }
                        }),
                        SizedBox(height: 20),
                        Center(
                          child:
                          Elevated_button(
                            text: 'Pay Now',
                            color: Colors.white,
                            backcolor: Colors.teal.shade800,
                            padding: 10,
                            width: Get.width,
                            radius: 10,
                            path: () async {
                              try{
                                User? user = FirebaseAuth.instance.currentUser;
                                DocumentSnapshot<Map<String, dynamic>> UserData =
                                await FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(user!.uid)
                                    .get();
                                await storeDonationData(
                                  studentId: user.uid,
                                  name: UserData['name'],
                                  email: UserData['email'],
                                  donatedAmount: double.parse(amountController.text),
                                  semester: UserData['semester'],
                                  department: UserData['department'],
                                  rollNo: UserData['roll_no'],
                                  needyPersonName: this.needyPersonName,
                                );
                              }
                              catch (e){
                                showErrorSnackbar(e.toString());
                              }finally{
                                amountController.clear();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
