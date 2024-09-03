import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/ForgotPassword.dart';
import 'package:upr_fund_collection/Portals/AdminPortal/AdminDashboardScreen.dart';
import 'package:upr_fund_collection/Controllers/LoginController.dart';
import 'package:upr_fund_collection/Controllers/PasswordControllers.dart';
import 'package:upr_fund_collection/CustomWidgets/ElevatedButton.dart';
import 'package:upr_fund_collection/CustomWidgets/IconButton.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';
import 'package:upr_fund_collection/Portals/DonorPortal/DonorDashboard.dart';
import 'package:upr_fund_collection/DonorSignup.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController loginController = Get.put(LoginController());
  final Password_controller _visibilityController=Get.put(Password_controller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.teal.shade700.withOpacity(0.2),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.volunteer_activism_rounded,
                      size: 50,
                      color:Colors.teal.shade700,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Log In Text
                Text(
                  'Log In Now',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade700,
                  ),
                ),
                SizedBox(height: 8),

                TextWidget(
                 title:  'Please login to continue using our app',
                  size: 16, color: Colors.grey,
                ),
                SizedBox(height: 30),

                // Email TextField
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: loginController.emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                Obx((){
                  return TextFormField(
                    keyboardType: TextInputType.text,
                    controller: loginController.passwordController,
                    obscureText: _visibilityController.show.value,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: Icon_Button(
                        onPressed: (){
                          _visibilityController.show_password();
                        },
                        icon: _visibilityController.show.value==true?Icon(Icons.remove_red_eye_outlined):Icon(Icons.remove_red_eye),
                      ),
                    ),
                  );
                }),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                         Get.to(ForgotPasswordPage());
                    },
                    child: TextWidget(
                      title: 'Forgot Password?',
                      color: Colors.teal.shade700,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                    child:Obx((){
                      return loginController.isLoading.value?Center(child: CircularProgressIndicator()):
                      Elevated_button(
                        path:loginController.login,
                        color: Colors.white,
                        backcolor: Colors.teal.shade700,
                        text: 'Login',
                        radius: 10,
                        padding: 10,
                      );
                    })
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(title: "Don't have an account? "),
                    GestureDetector(
                      onTap: () {
                        Get.to(SignUpPage());
                      },
                      child: TextWidget(
                        title: 'Sign Up',
                      color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextWidget(title: 'Or connect with'),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.facebook),
                      color: Colors.blue,
                      onPressed: () {
                        // Facebook Login functionality
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.mail_outline),
                      color: Colors.red,
                      onPressed: () {
                        // Google Login functionality
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.g_mobiledata),
                      color: Colors.blue[700],
                      onPressed: () {
                        // LinkedIn Login functionality
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
