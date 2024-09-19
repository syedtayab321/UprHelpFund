import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';

class FeedbackModel {
  final String id;
  final String userName;
  final String profession;
  final String feedback;
  final DateTime date;
  final double rating; // Added rating attribute

  FeedbackModel({
    required this.id,
    required this.userName,
    required this.profession,
    required this.feedback,
    required this.date,
    required this.rating, // Include rating in constructor
  });

  factory FeedbackModel.fromFirestore(Map<String, dynamic> data, String id) {
    return FeedbackModel(
      id: id,
      userName: data['UserName'] ?? 'Anonymous',
      profession: data['Profession'] ?? 'Unknown',
      feedback: data['feedback'] ?? '',
      date: (data['timestamp'] as Timestamp).toDate(),
      rating: data['rating']?.toDouble() ?? 0.0, // Extract rating, default to 0.0
    );
  }
}

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(title: 'Feedbacks', color: Colors.white),
        backgroundColor: Colors.teal.shade800,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Feedback')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<FeedbackModel> feedbackList = snapshot.data!.docs.map((doc) {
            return FeedbackModel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
          }).toList();

          if (feedbackList.isEmpty) {
            return Center(child: Text('No feedback available.'));
          }

          return ListView.builder(
            itemCount: feedbackList.length,
            itemBuilder: (context, index) {
              final feedback = feedbackList[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                elevation: 5,
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  title: TextWidget(title: feedback.userName, size: 18.0, weight: FontWeight.bold),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(title: feedback.profession, size: 14.0, color: Colors.grey.shade700),
                      SizedBox(height: 8.0),
                      TextWidget(title: feedback.feedback, size: 16.0),
                      SizedBox(height: 8.0),
                      RatingBar.builder(
                        initialRating: feedback.rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        ignoreGestures: true,
                        onRatingUpdate:(double){

                        },// Disable interactions
                      ),
                    ],
                  ),
                  trailing: TextWidget(title: '${feedback.date.day}/${feedback.date.month}/${feedback.date.year}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
