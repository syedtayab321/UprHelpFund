import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/ElevatedButton.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';
class DonationRequest {
  final String title;
  final String description;
  final double amountNeeded;
  final String imageUrl;

  DonationRequest({
    required this.title,
    required this.description,
    required this.amountNeeded,
    required this.imageUrl,
  });
}


class DonationRequestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(title: 'Donation Requests',color: Colors.black,),
      ),
      body: ListView.builder(
        itemCount: donationRequests.length,
        itemBuilder: (context, index) {
          return DonationRequestCard(
            donationRequest: donationRequests[index],
          );
        },
      ),
    );
  }
}
final List<DonationRequest> donationRequests = [
  DonationRequest(
    title: 'Help Build a School',
    description: 'We are raising funds to build a school in a remote village.',
    amountNeeded: 5000.00,
    imageUrl: 'https://example.com/school.jpg',
  ),
  DonationRequest(
    title: 'Medical Aid for Children',
    description: 'Providing medical aid for children affected by war.',
    amountNeeded: 3000.00,
    imageUrl: 'https://example.com/medical.jpg',
  ),
];

class DonationRequestCard extends StatelessWidget {
  final DonationRequest donationRequest;

  DonationRequestCard({required this.donationRequest});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.blue,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  title:donationRequest.title,
                  size: 18,
                  weight: FontWeight.bold,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                TextWidget(
                 title:  donationRequest.description,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(height: 10),
                TextWidget(
                 title:  'Amount Needed: \$${donationRequest.amountNeeded}',
                  size: 16,
                    color: Colors.white,
                ),
                SizedBox(height: 15),
                Center(
                  child: Elevated_button(
                    path: (){},
                    text: 'Donate Now',
                    radius: 10,
                    padding: 10,
                    backcolor: Colors.blue.shade800,
                    color: Colors.white,
                    fontsize: 20,
                    width: Get.width,
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

