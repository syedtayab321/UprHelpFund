import 'package:flutter/material.dart';

class AdsaNotificationsPage extends StatelessWidget {
  // Dummy data for notifications
  final List<Map<String, String>> notifications = [
    {
      'title': 'New Message',
      'description': 'You have a new message from John Doe.',
      'time': '10:30 AM'
    },
    {
      'title': 'Meeting Reminder',
      'description': 'Don’t forget your meeting at 11:00 AM.',
      'time': '9:45 AM'
    },
    {
      'title': 'Project Deadline',
      'description': 'The deadline for the project is tomorrow.',
      'time': 'Yesterday'
    },
    {
      'title': 'System Update',
      'description': 'A new system update is available.',
      'time': '2 days ago'
    },
    {
      'title': 'New Comment',
      'description': 'Someone commented on your post.',
      'time': '3 days ago'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.teal.shade700,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 4.0,
            child: ListTile(
              leading: Icon(
                Icons.notifications,
                color: Colors.teal.shade600,
                size: 40,
              ),
              title: Text(
                notification['title']!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                notification['description']!,
                style: TextStyle(fontSize: 16),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(
                notification['time']!,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              onTap: () {
                // Handle tap if necessary
              },
            ),
          );
        },
      ),
    );
  }
}
