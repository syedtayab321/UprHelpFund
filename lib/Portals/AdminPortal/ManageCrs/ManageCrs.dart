import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/ElevatedButton.dart';
import 'package:upr_fund_collection/CustomWidgets/Snakbar.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';
import 'package:upr_fund_collection/DatabaseDataControllers/ManagingCrDataController.dart';
import 'package:upr_fund_collection/Models/CrModal.dart';
import 'package:upr_fund_collection/Portals/AdminPortal/ManageCrs/AddCr.dart';

class ClassReportersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          title: 'Class Reporters',
          color: Colors.white,
        ),
        backgroundColor: Colors.teal.shade700,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Elevated_button(
              text: 'Add CR',
              color: Colors.white,
              path: () {
                Get.to(ClassReporterForm());
              },
              radius: 10,
              padding: 3,
              width: 130,
              height: 40,
              backcolor: Colors.teal.shade900,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<List<ClassReporter>>(
          stream: _fetchClassReporters(), // Add your stream source here
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No Class Reporters found.'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ClassReporterCard(reporter: snapshot.data![index]);
                },
              );
            }
          },
        ),
      ),
    );
  }
  Stream<List<ClassReporter>> _fetchClassReporters() async* {
    // Fetch all documents in the 'classReporters' collection
    final classReporterDocs = await FirebaseFirestore.instance
        .collection('classReporters')
        .get();

    // Initialize a list to store ClassReporter objects
    List<ClassReporter> allClassReporters = [];

    // For each document in the 'classReporters' collection
    for (var doc in classReporterDocs.docs) {
      // Fetch the subcollection 'crs' for each document
      var crsSnapshot = await doc.reference.collection('crs').get();

      // Convert each document in 'crs' subcollection to ClassReporter object and add to the list
      var classReporters = crsSnapshot.docs
          .map((crsDoc) => ClassReporter.fromFirestore(crsDoc.data()))
          .toList();

      allClassReporters.addAll(classReporters);
    }

    // Return the complete list of ClassReporter objects
    yield allClassReporters;
  }

}


class ClassReporterCard extends StatelessWidget {
  final ClassReporter reporter;
  ClassReporterCard({required this.reporter});
  final ManagingCrDataController _controller=Get.put(ManagingCrDataController());
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.teal.shade100,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(reporter.profilePhoto),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      title: reporter.name,
                      size: 18,
                      weight: FontWeight.bold,
                      color: Colors.teal.shade900,
                    ),
                    SizedBox(height: 4),
                    TextWidget(
                      title:'Roll No:  ${reporter.rollNumber.toString()}',
                      size: 14,
                      color: Colors.teal.shade600,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildInfoRow(Icons.school, 'Department: ', reporter.department),
            _buildInfoRow(Icons.calendar_today, 'Semester: ', reporter.semester),
            _buildInfoRow(Icons.date_range, 'Session: ', reporter.session),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Elevated_button(
                  text: 'Update',
                  color: Colors.white,
                  path: () {},
                  radius: 10,
                  padding: 3,
                  width: 80,
                  height: 40,
                  backcolor: Colors.teal.shade700,
                ),
                Elevated_button(
                  text: 'Delete',
                  color: Colors.white,
                  path: () async{
                    try{
                      await  _controller.DeleteCrData(reporter.department,reporter.semester);
                      showSuccessSnackbar('Data Deleted Sucessfully');
                    }
                    catch (e){
                      showErrorSnackbar(e.toString());
                    }
                  },
                  radius: 10,
                  padding: 3,
                  width: 80,
                  height: 40,
                  backcolor: Colors.red.shade600,
                ),
                Elevated_button(
                  text: 'View Donations',
                  color: Colors.white,
                  path: () {},
                  radius: 10,
                  padding: 3,
                  width: 130,
                  height: 40,
                  backcolor: Colors.teal.shade900,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal.shade700),
          SizedBox(width: 8),
          TextWidget(
            title: label,
            weight: FontWeight.bold,
            color: Colors.teal.shade800,
          ),
          Expanded(
            child: TextWidget(
              title: value,
              color: Colors.teal.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
