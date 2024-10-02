// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:upr_fund_collection/CustomWidgets/Snakbar.dart';
//
// class PaymentProcessor {
//   final String baseUrl = 'http://192.168.249.18:3000';
//   // Function to handle EasyPaisa/JazzCash payment
//   Future<void> processMobilePayment(String mobileNumber, String method, double amount) async {
//     try {
//       final url = Uri.parse('$baseUrl/processMobilePayment');
//       final body = jsonEncode({
//         'mobileNumber': mobileNumber,
//         'method': method,
//         'amount': amount,
//       });
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: body,
//       );
//
//       if (response.statusCode == 200) {
//         print("$method payment successful for mobile number: $mobileNumber");
//       } else {
//         print("Error in processing $method payment: ${response.body}");
//       }
//     } catch (e) {
//       print("Error in processing $method payment: $e");
//     }
//   }
//   Future<void> processCardPayment({
//     required String cardNumber,
//     required String expiryDate,
//     required String cvc,
//     required double amount,
//   }) async {
//     try {
//       final url = Uri.parse('$baseUrl/processCardPayment');
//       final body = jsonEncode({
//         'cardNumber': cardNumber,
//         'expiryDate': expiryDate,
//         'cvc': cvc,
//         'amount': amount,
//       });
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: body,
//       );
//
//       if (response.statusCode == 200) {
//         print("Credit Card payment successful for amount: $amount");
//         showSuccessSnackbar("Credit Card payment successful for amount: $amount");
//       } else {
//         print("Error in processing card payment: ${response.body}");
//         showErrorSnackbar("Error in processing card payment: ${response.body}");
//       }
//     } catch (e) {
//       showErrorSnackbar("Error in processing card payment: $e");
//       print("Error in processing card payment: $e");
//     }
//   }
//
//   // Function to handle manual "Pay by Hand" method
//   Future<void> processManualPayment({
//     required String name,
//     required String email,
//     required String rollNo,
//     required String semester,
//     required String department,
//     required double amount,
//   }) async {
//     try {
//       // API endpoint for manual payment
//       final url = Uri.parse('$baseUrl/processManualPayment');
//       final body = jsonEncode({
//         'name': name,
//         'email': email,
//         'rollNo': rollNo,
//         'semester': semester,
//         'department': department,
//         'amount': amount,
//       });
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: body,
//       );
//
//       if (response.statusCode == 200) {
//         print("Manual payment recorded successfully.");
//       } else {
//         print("Error in processing manual payment: ${response.body}");
//       }
//     } catch (e) {
//       print("Error in processing manual payment: $e");
//     }
//   }
// }



// path: () async {
// PaymentProcessor paymentProcessor = PaymentProcessor();
//
// double amount = double.parse(
//     amountController.text);
// if (_formKey.currentState!.validate()) {
// if (controller.selectedPaymentMethod.value ==
// 'EasyPaisa' ||
// controller.selectedPaymentMethod.value ==
// 'JazzCash') {
// await paymentProcessor.processMobilePayment(
// mobileController.text,
// controller.selectedPaymentMethod.value,
// amount,
// );
// } else
// if (controller.selectedPaymentMethod.value ==
// 'Credit Card') {
//
// // await paymentProcessor.processCardPayment(
// // cardNumber: cardNumberController.text,
// // expiryDate: cardExpiryController.text,
// // cvc: cardCvcController.text,
// // amount: amount, // Pass amount
// // );
// // } else
// // if (controller.selectedPaymentMethod.value ==
// // 'Pay by Hand') {
// // await paymentProcessor.processManualPayment(
// // name: nameController.text,
// // email: emailController.text,
// // rollNo: rollNoController.text,
// // semester: semesterController.text,
// // department: departmentController.text,
// // amount: amount, // Pass amount
// // );
// // }
// // }
// // },