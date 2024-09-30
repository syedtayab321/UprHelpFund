import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/PaymentRelated/PaymentMaking.dart';
import 'package:upr_fund_collection/CustomWidgets/ElevatedButton.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';

class PaymentController extends GetxController {
  var selectedPaymentMethod = 'EasyPaisa'.obs;
}

class PaymentPage extends StatelessWidget {
  final PaymentController controller = Get.put(PaymentController());

  final TextEditingController mobileController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardExpiryController = TextEditingController();
  final TextEditingController cardCvcController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController rollNoController = TextEditingController();
  final TextEditingController semesterController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
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
                        TextWidget(title: 'Select Payment Method', size: 16, weight: FontWeight.bold),
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
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
                                  TextWidget(title: 'Mobile Number', size: 16, weight: FontWeight.bold),
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
                                      } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                                        return 'Enter a valid mobile number (10 digits)';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  TextWidget(title: 'Amount', size: 16, weight: FontWeight.bold),
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
                                      } else if (double.tryParse(value) == null) {
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
                                  TextWidget(title: 'Card Number', size: 16, weight: FontWeight.bold),
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
                                      TextInputFormatter.withFunction((oldValue, newValue) {
                                        return TextEditingValue(
                                          text: formatCardNumber(newValue.text),
                                          selection: TextSelection.fromPosition(
                                            TextPosition(offset: formatCardNumber(newValue.text).length),
                                          ),
                                        );
                                      }),
                                    ],
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your card number';
                                      } else if (value.replaceAll(' ', '').length != 16) {
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
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter expiry date';
                                            } else if (!RegExp(r'^(0[1-9]|1[0-2])\/?([0-9]{2})$').hasMatch(value)) {
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
                                            if (value == null || value.isEmpty) {
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
                                  TextWidget(title: 'Amount', size: 16, weight: FontWeight.bold),
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
                                      } else if (double.tryParse(value) == null) {
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
                                  TextWidget(title: 'Name', size: 16, weight: FontWeight.bold),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter your name',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your name';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  TextWidget(title: 'Email', size: 16, weight: FontWeight.bold),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter your email',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email';
                                      } else if (!GetUtils.isEmail(value)) {
                                        return 'Enter a valid email';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  TextWidget(title: 'Roll Number', size: 16, weight: FontWeight.bold),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    controller: rollNoController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter your roll number',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your roll number';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  TextWidget(title: 'Semester', size: 16, weight: FontWeight.bold),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    controller: semesterController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter your semester',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your semester';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  TextWidget(title: 'Department', size: 16, weight: FontWeight.bold),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    controller: departmentController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter your department',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your department';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  TextWidget(title: 'Amount', size: 16, weight: FontWeight.bold),
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
                                      } else if (double.tryParse(value) == null) {
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
                          child: Elevated_button(
                            text: 'Pay Now',
                            color: Colors.white,
                            backcolor: Colors.teal.shade800,
                            padding: 10,
                            width: Get.width,
                            radius: 10,
                            path: () async {
                              PaymentProcessor paymentProcessor = PaymentProcessor();

                              double amount = double.parse(
                                  amountController.text);
                              if (_formKey.currentState!.validate()) {
                                if (controller.selectedPaymentMethod.value ==
                                    'EasyPaisa' ||
                                    controller.selectedPaymentMethod.value ==
                                        'JazzCash') {
                                  // Call the processMobilePayment function for EasyPaisa/JazzCash
                                  await paymentProcessor.processMobilePayment(
                                    mobileController.text,
                                    controller.selectedPaymentMethod.value,
                                    amount,
                                  );
                                } else
                                if (controller.selectedPaymentMethod.value ==
                                    'Credit Card') {
                                  // Call the processCardPayment function for Credit Card
                                  await paymentProcessor.processCardPayment(
                                    cardNumber: cardNumberController.text,
                                    expiryDate: cardExpiryController.text,
                                    cvc: cardCvcController.text,
                                    amount: amount, // Pass amount
                                  );
                                } else
                                if (controller.selectedPaymentMethod.value ==
                                    'Pay by Hand') {
                                  await paymentProcessor.processManualPayment(
                                    name: nameController.text,
                                    email: emailController.text,
                                    rollNo: rollNoController.text,
                                    semester: semesterController.text,
                                    department: departmentController.text,
                                    amount: amount, // Pass amount
                                  );
                                }
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
