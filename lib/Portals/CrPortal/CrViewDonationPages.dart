import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/Controllers/CrMainPageControllers.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';

class CrViewDonationPage extends StatelessWidget {
  final CrDonationController controller = Get.put(CrDonationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade700,
        title: TextWidget(title: 'Donations by Semester',
           weight: FontWeight.bold,
        color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildSemesterButton('Semester 1'), SizedBox(width: 10,),
                  buildSemesterButton('Semester 2'), SizedBox(width: 10,),
                  buildSemesterButton('Semester 3'), SizedBox(width: 10,),
                  buildSemesterButton('Semester 4'), SizedBox(width: 10,),
                  buildSemesterButton('Semester 5'), SizedBox(width: 10,),
                  buildSemesterButton('Semester 6'), SizedBox(width: 10,),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Obx(() {
              final donations = controller.getDonationsBySemester(controller.selectedSemester.value);

              if (donations.isEmpty) {
                return Center(
                  child: TextWidget(title: 'No donations found for this semester.', size: 18, color: Colors.redAccent),);
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                itemCount: donations.length,
                itemBuilder: (context, index) {
                  final donation = donations[index];
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: TextWidget(
                         title:  donation.name[0].toUpperCase(),
                         color: Colors.white, weight: FontWeight.bold,
                        ),
                      ),
                      title: TextWidget(
                        title:donation.name,
                        size: 18, weight: FontWeight.w600,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          TextWidget(title: 'Roll No: ${donation.rollNo}', size: 14),
                          TextWidget(title: 'Semester: ${donation.semester}', size: 14),
                          TextWidget(
                          title:   'Amount: \$${donation.donatedAmount}',
                            size: 16, weight: FontWeight.w600, color: Colors.green),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  // Function to build semester button
  Widget buildSemesterButton(String semester) {
    return ElevatedButton(
      onPressed: () {
        controller.selectedSemester.value = semester;
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurpleAccent,  // Use more vibrant button color
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        semester,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
