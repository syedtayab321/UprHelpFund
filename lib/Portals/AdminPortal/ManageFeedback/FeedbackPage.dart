import 'package:flutter/material.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';

class FeedbackModel {
  final String userName;
  final String feedback;
  final DateTime date;

  FeedbackModel({required this.userName, required this.feedback, required this.date});
}


class FeedbackPage extends StatelessWidget {

  final List<FeedbackModel> feedbackList = [
    FeedbackModel(userName: "John Doe", feedback: "Great service!", date: DateTime.now()),
    FeedbackModel(userName: "Jane Smith", feedback: "Loved the product quality.", date: DateTime.now().subtract(Duration(days: 1))),
    // Add more feedbacks
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(title: 'Feedbacks',color: Colors.white,),
        backgroundColor: Colors.teal.shade800,
      ),
      body: ListView.builder(
        itemCount: feedbackList.length,
        itemBuilder: (context, index) {
          final feedback = feedbackList[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: TextWidget(title:feedback.userName),
              subtitle: TextWidget(title:feedback.feedback),
              trailing: TextWidget(title: '${feedback.date.day}/${feedback.date.month}/${feedback.date.year}'),
            ),
          );
        },
      ),
    );
  }
}
