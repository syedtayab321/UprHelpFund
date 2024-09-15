import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/ElevatedButton.dart';
import 'package:upr_fund_collection/Models/LoginSharedPrefrencses.dart';
import 'package:upr_fund_collection/Portals/StudentPortal/StudentProfilePages/StudentContactus.dart';
import 'package:upr_fund_collection/Portals/StudentPortal/StudentProfilePages/StudentFeedback.dart';
import 'package:upr_fund_collection/Portals/StudentPortal/StudentProfilePages/StudentProfileUpdate.dart';

class DonorProfilePage extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('Users').doc(user!.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('User not found'));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.transparent,
                    backgroundImage: userData['profileImage'] != null
                        ? NetworkImage(userData['profileImage'])
                        : AssetImage('assets/images/app-icon-person.png') as ImageProvider,
                  ),
                  SizedBox(height: 20),
                  Text(
                    userData['name'] ?? 'N/A',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade800,
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        ProfileDetailRow(
                          icon: Icons.person,
                          label: 'User Id:',
                          value: userData['uid'] ?? 'N/A',
                        ),
                        ProfileDetailRow(
                          icon: Icons.email,
                          label: 'Email:',
                          value: userData['email'] ?? 'N/A',
                        ),
                        ProfileDetailRow(
                          icon: Icons.person,
                          label: 'Role:',
                          value: userData['role'] ?? 'N/A',
                        ),
                        ProfileDetailRow(
                          icon: Icons.person,
                          label: 'Semester:',
                          value: userData['semester'] ?? 'N/A',
                        ),
                        ProfileDetailRow(
                          icon: Icons.account_balance_outlined,
                          label: 'Department:',
                          value: userData['department'] ?? 'N/A',
                        ),
                        Elevated_button(
                            text:'Edit',
                            color: Colors.white,
                            backcolor: Colors.teal,
                            padding: 10,
                            radius: 10,
                            height: 10,
                            width: 170,
                            path: (){
                              Get.to(
                                  UpdateStudentPage(
                                    name: userData['name'],
                                    department: userData['department'],
                                    semester: userData['semester'],
                                  ),
                              );
                            }
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildActionListTiles(context),
                  SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionListTiles(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.feedback, color: Colors.teal),
          title: Text('Give Feedback'),
          onTap: () {
            Get.to(DonorFeedbackPage());
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.contact_mail, color: Colors.teal),
          title: Text('Contact Us'),
          onTap: () {
            Get.to(DonorContactUsPage());
          },
        ),
      ],
    );
  }
}

// Custom Widget for Profile Details Row
class ProfileDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileDetailRow({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal.shade700),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        value,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
    );
  }
}
