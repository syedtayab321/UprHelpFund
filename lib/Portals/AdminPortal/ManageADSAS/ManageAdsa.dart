import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/ElevatedButton.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';
import 'package:upr_fund_collection/Models/AdsaModal.dart';

class ADSAdataPage extends StatelessWidget {
  final List<AdsaData> adsaList = [
    AdsaData(
      name: 'John Doe',
      email: 'johndoe@example.com',
      department: 'Computer Science',
      campus: 'Main Campus',
    ),
    AdsaData(
      name: 'Jane Smith',
      email: 'janesmith@example.com',
      department: 'Business Administration',
      campus: 'City Campus',
    ),
    AdsaData(
      name: 'Alice Brown',
      email: 'alicebrown@example.com',
      department: 'Electrical Engineering',
      campus: 'West Campus',
    ),
    // Add more AdsaData objects here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(title: '(ADSA)',color: Colors.white,),
        backgroundColor: Colors.teal.shade700,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Elevated_button(
              text: 'Add ADSA',
              color: Colors.white,
              path: () {

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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade50, Colors.teal.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: adsaList.length,
          itemBuilder: (context, index) {
            final adsa = adsaList[index];
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
                      title:adsa.name,
                      weight: FontWeight.bold,
                        size: 20,
                        color: Colors.teal.shade900,
                      ),
                    SizedBox(height: 8),
                    _buildInfoRow(Icons.email, 'Email: ', adsa.email),
                    _buildInfoRow(Icons.business, 'Department: ', adsa.department),
                    _buildInfoRow(Icons.location_city, 'Campus: ', adsa.campus),
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
                          path: () {},
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
          },
        ),
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
