import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/ConfirmDialogBox.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';
import 'package:upr_fund_collection/Models/LoginSharedPrefrencses.dart';
import 'package:upr_fund_collection/Portals/CrPortal/CrViewDonationPages.dart';

class CrHomePage extends StatefulWidget {
  @override
  _CrHomePageState createState() => _CrHomePageState();
}

class _CrHomePageState extends State<CrHomePage> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";
  final AuthService _authService = AuthService();
  // Search function to filter departments
  void _searchDepartments(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
    });
  }

  void logout(BuildContext context) async {
    await Get.dialog(
      ConfirmDialog(
        title: 'Logout',
        content: 'Are you sure you want to logout?',
        confirmText: 'Confirm',
        cancelText: 'Cancel',
        onConfirm: () {
          _authService.signOut();
        },
        onCancel: () {
          Get.back();
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(title: 'Cr Home Page',color:Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: (){
              logout(context);
            },
          ),
        ],
        backgroundColor: Colors.teal.shade700,
        elevation: 4,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _searchDepartments,
              decoration: InputDecoration(
                labelText: "Search Department",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // StreamBuilder for real-time updates
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Donations').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                // Filtering based on search query
                final departments = snapshot.data!.docs.where((doc) {
                  final departmentName = doc.id.toLowerCase();
                  return departmentName.contains(searchQuery);
                }).toList();

                if (departments.isEmpty) {
                  return Center(child: Text('No departments found'));
                }

                return ListView.builder(
                  itemCount: departments.length,
                  itemBuilder: (context, index) {
                    String departmentName = departments[index].id;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Colors.teal.shade700,
                        elevation: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              child: Icon(Icons.business, color: Colors.white),
                            ),
                            title: TextWidget(
                             title:  departmentName,
                              size: 24,
                                  color: Colors.white
                            ),
                            trailing: Icon(Icons.arrow_forward_ios,
                                color: Colors.white
                            ),
                            onTap: () {
                              Get.to(CrViewDonationPage());
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
