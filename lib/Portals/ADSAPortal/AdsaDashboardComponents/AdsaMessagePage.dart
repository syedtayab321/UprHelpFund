import 'package:flutter/material.dart';

class AdsaMessagesPage extends StatelessWidget {
  // Dummy data for messages
  final List<Map<String, String>> messages = [
    {
      'sender': 'John Doe',
      'message': 'Hey! How are you?',
      'time': '10:30 AM'
    },
    {
      'sender': 'Jane Smith',
      'message': 'Can we schedule a meeting?',
      'time': '9:15 AM'
    },
    {
      'sender': 'Alex Johnson',
      'message': 'Project update: All tasks completed.',
      'time': 'Yesterday'
    },
    {
      'sender': 'Emily Davis',
      'message': 'Happy Birthday!',
      'time': 'Yesterday'
    },
    {
      'sender': 'Michael Brown',
      'message': 'Let’s catch up soon.',
      'time': '2 days ago'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
        backgroundColor: Colors.teal.shade700,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 4.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.teal.shade400,
                child: Text(
                  message['sender']![0], // First letter of the sender's name
                  style: TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                message['sender']!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                message['message']!,
                style: TextStyle(fontSize: 16),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(
                message['time']!,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              onTap: () {
                // Navigate to detailed message view if necessary
              },
            ),
          );
        },
      ),
    );
  }
}
