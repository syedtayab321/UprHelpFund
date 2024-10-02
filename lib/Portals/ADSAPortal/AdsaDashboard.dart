import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/ConfirmDialogBox.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';
import 'package:upr_fund_collection/Models/LoginSharedPrefrencses.dart';
import 'package:upr_fund_collection/Portals/ADSAPortal/AdsaViewDonationPage.dart';

class ADSADashboardPage extends StatefulWidget {
  @override
  _ADSADashboardPageState createState() => _ADSADashboardPageState();
}

class _ADSADashboardPageState extends State<ADSADashboardPage> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";
  final AuthService _authService = AuthService();

  // Search function to filter departments
  void _searchDepartments(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
    });
  }

  Future<List<Map<String, dynamic>>> _fetchDepartments() async {
    List<Map<String, dynamic>> allDepartments = [];

    // Fetch all documents from Donations collection
    QuerySnapshot donationsSnapshot = await FirebaseFirestore.instance.collection('StudentDonations').get();

    // Iterate over each document to fetch subdocuments
    for (var document in donationsSnapshot.docs) {
      QuerySnapshot subDocsSnapshot = await FirebaseFirestore.instance
          .collection('StudentDonations')
          .doc(document.id)
          .collection('NeedyPersons')
          .get();

      // Extract department data from subdocuments
      for (var subDoc in subDocsSnapshot.docs) {
        final departmentData = subDoc.data() as Map<String, dynamic>;
        final departmentName = departmentData['department'] ?? 'Unknown';

        // Filter based on search query
        if (departmentName.toLowerCase().contains(searchQuery)) {
          allDepartments.add({
            'departmentName': departmentName,
            'data': departmentData,
          });
        }
      }
    }

    return allDepartments;
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
        title: TextWidget(title: 'ADSA Home Page', color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
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

          // FutureBuilder for fetching departments and rendering UI
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchDepartments(), // Fetch departments asynchronously
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final allDepartments = snapshot.data ?? [];

                if (allDepartments.isEmpty) {
                  return Center(child: Text('No departments found'));
                }

                // Displaying the departments
                return ListView.builder(
                  itemCount: allDepartments.length,
                  itemBuilder: (context, index) {
                    String departmentName = allDepartments[index]['departmentName'];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                                title: departmentName,
                                size: 24,
                                color: Colors.white),
                            trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                            onTap: () {
                              Get.to(() => AdsaViewDonationPage(
                                // departmentData: allDepartments[index]['data'],
                              ));
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
