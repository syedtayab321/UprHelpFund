import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/ElevatedButton.dart';
import 'package:upr_fund_collection/CustomWidgets/Snakbar.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';
import 'package:upr_fund_collection/DatabaseDataControllers/ManagingAdsaDataController.dart';
import 'package:upr_fund_collection/Portals/AdminPortal/ManageADSAS/AddAdsaForm.dart';

class ADSAdataPage extends StatefulWidget {
  @override
  _ADSAdataPageState createState() => _ADSAdataPageState();
}

class _ADSAdataPageState extends State<ADSAdataPage> {
  final ManagingAdsaDataController _controller=Get.put(ManagingAdsaDataController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          title: '(ADSA)',
          color: Colors.white,
        ),
        backgroundColor: Colors.teal.shade700,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Elevated_button(
              text: 'Add ADSA',
              color: Colors.white,
              path: () {
                Get.to(AdsaForm());
              },
              radius: 10,
              padding: 3,
              width: 130,
              height: 40,
              backcolor: Colors.blue,
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Adsa').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No data available'));
          }
          // Getting documents from the 'Adsa' collection
          final List<QueryDocumentSnapshot> adsaDocs = snapshot.data!.docs;

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: adsaDocs.length,
            itemBuilder: (context, index) {
              final adsaDoc = adsaDocs[index];

              // Query the sub-collection 'adsa_dep' for each document
              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Adsa')
                    .doc(adsaDoc.id)
                    .collection('adsa_dep')
                    .snapshots(),
                builder: (context, subSnapshot) {
                  if (subSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!subSnapshot.hasData) {
                    return Center(child: Text('No sub-documents available'));
                  }

                  final List<QueryDocumentSnapshot> subDocs =
                      subSnapshot.data!.docs;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: subDocs.map((subDoc) {
                      final data = subDoc.data() as Map<String, dynamic>;

                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                title: data['adsa_name'] ?? 'Unknown',
                                weight: FontWeight.bold,
                                size: 20,
                                color: Colors.teal.shade900,
                              ),
                              SizedBox(height: 8),
                              _buildInfoRow(Icons.email, 'Email: ', data['adsa_email'] ?? 'N/A'),
                              _buildInfoRow(Icons.business, 'Department: ', data['department'] ?? 'N/A'),
                              _buildInfoRow(Icons.location_city, 'Campus: ', data['Campus'] ?? 'N/A'),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Elevated_button(
                                    text: 'Delete',
                                    color: Colors.white,
                                    path: () async{
                                      try{
                                       await  _controller.DeleteAdsaData(data['department'], data['Campus']);
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
                                    text: 'Message',
                                    color: Colors.white,
                                    path: () {
                                      // Implement view donations functionality
                                    },
                                    radius: 10,
                                    padding: 3,
                                    width: 100,
                                    height: 40,
                                    backcolor: Colors.teal.shade900,
                                  ),
                                  Elevated_button(
                                    text: 'View Donations',
                                    color: Colors.white,
                                    path: () {
                                      // Implement view donations functionality
                                    },
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
                    }).toList(),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal.shade600),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade700,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.teal.shade800),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
