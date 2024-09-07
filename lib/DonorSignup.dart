import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/ElevatedButton.dart';
import 'package:upr_fund_collection/CustomWidgets/Snakbar.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';
import 'package:upr_fund_collection/Login.dart';

class SignUpPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Create the user
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        User? user = userCredential.user;
        if (user != null && !user.emailVerified) {
          await user.sendEmailVerification();
          showSuccessSnackbar('Email verification send Successfully check You email');

          _firestore.collection('Users').doc(user.uid).set({
            'name': _nameController.text.trim(),
            'email': _emailController.text.trim(),
            'role': 'User',
            'uid': user.uid,
          });
          await _auth.signOut();
          Get.off(LoginPage());
        }
      } on FirebaseAuthException catch (e) {
        showErrorSnackbar(e.message.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
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
                        color: Colors.teal.shade700,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Sign Up Now',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color:Colors.teal.shade700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Please fill the details to create an account',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: Elevated_button(
                      path: _signUp,
                      color: Colors.white,
                      backcolor: Colors.teal.shade700,
                      text: 'Signup',
                      radius: 10,
                      padding: 10,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(title: "Already have an account? "),
                      GestureDetector(
                        onTap: () {
                          Get.to(LoginPage());
                        },
                        child: TextWidget(
                          title: 'Log In',
                          color: Colors.teal.shade700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text('Or connect with'),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.facebook),
                        color: Colors.blue,
                        onPressed: () {
                          // Facebook Sign Up functionality
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.mail_outline),
                        color: Colors.red,
                        onPressed: () {
                          // Google Sign Up functionality
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.mail),
                        color: Colors.blue[700],
                        onPressed: () {
                          // LinkedIn Sign Up functionality
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
