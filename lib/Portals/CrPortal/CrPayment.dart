import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/ElevatedButton.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';

// Controller for GetX State Management
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

  // Payment methods list
  final List<String> paymentMethods = [
    'EasyPaisa',
    'JazzCash',
    'Credit Card',
    'Pay by Hand',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(title: 'Make Payment',color: Colors.white,),
        backgroundColor: Colors.teal.shade800,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Payment Method Dropdown
                    TextWidget(
                      title: 'Select Payment Method',
                      size: 16, weight: FontWeight.bold),
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
                              TextWidget(
                                title: 'Mobile Number',
                                size: 16, weight: FontWeight.bold),
                              SizedBox(height: 10),
                              TextField(
                                controller: mobileController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter your mobile number',
                                ),
                              ),
                            ],
                          );
                        case 'Credit Card':
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                title: 'Card Number',
                                size: 16, weight: FontWeight.bold),
                              SizedBox(height: 10),
                              TextField(
                                controller: cardNumberController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter card number',
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: cardExpiryController,
                                      keyboardType: TextInputType.datetime,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'MM/YY',
                                        labelText: 'Expiry Date',
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      controller: cardCvcController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'CVC',
                                        labelText: 'CVC',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        case 'Pay by Hand':
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(title: 'Name',
                                  size: 16,
                                      weight: FontWeight.bold),
                              SizedBox(height: 10),
                              TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter your name',
                                ),
                              ),
                              SizedBox(height: 10),
                              TextWidget(title: 'Email',
                                  size: 16,
                                      weight: FontWeight.bold),
                              SizedBox(height: 10),
                              TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter your email',
                                ),
                              ),
                              SizedBox(height: 10),
                              TextWidget(
                                  title: 'Roll No.',
                                  size: 16,
                                      weight: FontWeight.bold),
                              SizedBox(height: 10),
                              TextField(
                                controller: rollNoController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter your roll number',
                                ),
                              ),
                              SizedBox(height: 10),
                              TextWidget(title: 'Semester',
                                  size: 16,
                                 weight: FontWeight.bold),
                              SizedBox(height: 10),
                              TextField(
                                controller: semesterController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter your semester',
                                ),
                              ),
                              SizedBox(height: 10),
                              TextWidget(title:'Department',
                                  size: 16,
                                  weight: FontWeight.bold),
                              SizedBox(height: 10),
                              TextField(
                                controller: departmentController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter your department',
                                ),
                              ),
                              SizedBox(height: 10),
                              TextWidget(
                                 title:'Amount',
                                  size: 16,
                                  weight: FontWeight.bold),
                              SizedBox(height: 10),
                              TextField(
                                controller: amountController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter the amount',
                                ),
                              ),
                            ],
                          );
                        default:
                          return SizedBox.shrink();
                      }
                    }),
                    SizedBox(height: 30),

                    // Pay Button with Enhanced Design
                    Center(
                      child: Elevated_button(
                          text: 'Pay Now',
                          color: Colors.white,
                          backcolor: Colors.teal.shade800,
                          padding: 10,
                          width: Get.width,
                          radius: 10,
                          path: (){
                            // Handle payment submission based on the selected method
                            if (controller.selectedPaymentMethod.value ==
                                'EasyPaisa' ||
                                controller.selectedPaymentMethod.value ==
                                    'JazzCash') {
                              print(
                                  'Selected Mobile Payment: ${mobileController.text}');
                            } else if (controller.selectedPaymentMethod.value ==
                                'Credit Card') {
                              print(
                                  'Card Payment: ${cardNumberController.text}, Expiry: ${cardExpiryController.text}, CVC: ${cardCvcController.text}');
                            } else if (controller.selectedPaymentMethod.value ==
                                'Pay by Hand') {
                              print(
                                  'Pay by Hand: Name: ${nameController.text}, Email: ${emailController.text}, Roll No: ${rollNoController.text}, Semester: ${semesterController.text}, Department: ${departmentController.text}, Amount: ${amountController.text}');
                            }
                          },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
