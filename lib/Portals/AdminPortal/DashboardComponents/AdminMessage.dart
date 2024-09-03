import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';
import 'package:upr_fund_collection/Models/AdminMessageModal.dart';
import 'package:upr_fund_collection/Portals/AdminPortal/DashboardComponents/AdminConversationPage.dart';

class AdminMessagesPage extends StatelessWidget {
  // Sample list of messages
  final List<AdminMessage> messages = [
    AdminMessage(
      userName: 'John Doe',
      messageContent: 'Hello, I need some help with my order.',
      timestamp: DateTime.now().subtract(Duration(minutes: 5)),
    ),
    AdminMessage(
      userName: 'Jane Smith',
      messageContent: 'When will my package arrive?',
      timestamp: DateTime.now().subtract(Duration(hours: 1)),
    ),
    AdminMessage(
      userName: 'Alice Brown',
      messageContent: 'I am interested in your services.',
      timestamp: DateTime.now().subtract(Duration(days: 1)),
    ),
    // Add more messages here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade700, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            return InkWell(
              onTap: (){
                Get.to(AdminConversationPage());
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  tileColor: Colors.white,
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal.shade700,
                    child: TextWidget(
                     title:  message.userName[0], // Initials of the username
                      color: Colors.white, size: 20
                    ),
                  ),
                  title: TextWidget(
                   title:  message.userName,
                    weight: FontWeight.bold,
                      size: 18,
                      color: Colors.teal.shade700,
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextWidget(
                     title:  message.messageContent,
                      size: 16, color: Colors.black87
                    ),
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.message_outlined,
                        color: Colors.teal.shade700,
                      ),
                      SizedBox(height: 5),
                      Text(
                        _formatTimestamp(message.timestamp),
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    return '${timestamp.day}/${timestamp.month}/${timestamp.year} ${timestamp.hour}:${timestamp.minute}';
  }
}
