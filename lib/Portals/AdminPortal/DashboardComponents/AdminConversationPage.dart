import 'package:flutter/material.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';

class AdminConversationPage extends StatelessWidget {
  // Dummy data for the conversation
  final List<Map<String, dynamic>> messages = [
    {
      'sender': 'User',
      'message': 'Hi, how are you?',
      'time': '10:00 AM',
      'isSentByMe': true,
    },
    {
      'sender': 'Admin',
      'message': 'I am good, thank you! How can I help you?',
      'time': '10:02 AM',
      'isSentByMe': false,
    },
    {
      'sender': 'User',
      'message': 'I need some information about your services.',
      'time': '10:05 AM',
      'isSentByMe': true,
    },
    {
      'sender': 'Admin',
      'message': 'Sure, what do you want to know?',
      'time': '10:06 AM',
      'isSentByMe': false,
    },
    {
      'sender': 'User',
      'message': 'Can you provide more details on pricing?',
      'time': '10:07 AM',
      'isSentByMe': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(title: 'Conversation',color: Colors.white,),
        backgroundColor: Colors.teal.shade700,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isSentByMe = message['isSentByMe'] as bool;
                return Align(
                  alignment:
                  isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
                    margin: EdgeInsets.symmetric(vertical: 6.0),
                    constraints: BoxConstraints(maxWidth: 300),
                    decoration: BoxDecoration(
                      color: isSentByMe ? Colors.teal.shade100 : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      crossAxisAlignment: isSentByMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                         title:  message['message']!,
                          size: 16.0,
                        ),
                        SizedBox(height: 4.0),
                        TextWidget(
                         title:  message['time']!,
                          size: 12.0,
                            color: Colors.grey.shade600,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.teal),
                  onPressed: () {
                    // Placeholder for send button functionality
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
