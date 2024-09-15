import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/ElevatedButton.dart';
import 'package:upr_fund_collection/CustomWidgets/Snakbar.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';

class UpdateStudentPage extends StatefulWidget {
  late String name;
  late String semester;
  late String department;

  UpdateStudentPage({required this.name, required this.semester, required this.department});

  @override
  _UpdateStudentPageState createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _semester;
  late String _department;

  final List<String> _semesters = [
    'Semester 1', 'Semester 2',
    'Semester 3', 'Semester 4',
    'Semester 5', 'Semester 6',
    'Semester 7', 'Semester 8'
  ];

  final List<String> _departments = [
    'Computer Science', 'Electrical Engineering',
    'Mechanical Engineering', 'Civil Engineering',
    'Chemical Engineering'
  ];

  @override
  void initState() {
    super.initState();
    _name = widget.name;
    _semester = widget.semester;
    _department = widget.department;
  }

  void _updateUser() async{
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        widget.name = _name;
        widget.semester = _semester;
        widget.department = _department;
      });
   User? user =   await FirebaseAuth.instance.currentUser;
   try{
      await FirebaseFirestore.instance.collection('Users').doc(user!.uid).update(
        {
          'name':widget.name,
          'department':widget.department,
          'semester':widget.semester,
        });
      showSuccessSnackbar('Student Data Updated Sucessfully');
   } catch(e){
     showErrorSnackbar(e.toString());
   }finally{
     Get.back();
   }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(title: 'Update Student Data',color:Colors.white ,),
        backgroundColor: Colors.teal.shade800,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        title: 'Update Information',
                        size: 24,
                        weight: FontWeight.bold,
                          color: Colors.blueAccent,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        initialValue: _name,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        onSaved: (value) => _name = value!,
                      ),
                      SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        value: _semester,
                        decoration: InputDecoration(
                          labelText: 'Semester',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.school),
                        ),
                        items: _semesters.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _semester = newValue!;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a semester';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        value: _department,
                        decoration: InputDecoration(
                          labelText: 'Department',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.engineering),
                        ),
                        items: _departments.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _department = newValue!;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a department';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      Center(
                        child: Elevated_button(
                          text: 'Update',
                          backcolor: Colors.blueAccent,
                          padding: 10,
                          radius: 6,
                          width: 200,
                          height: 15,
                          color: Colors.white,
                          path: _updateUser,
                        )
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
