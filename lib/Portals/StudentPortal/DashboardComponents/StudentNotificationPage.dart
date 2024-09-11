import 'package:flutter/material.dart';

class DonorNotificationsPage extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'title': 'Donation Received',
      'message': 'Your donation has been received successfully.',
      'time': '2 hours ago'
    },
    {
      'title': 'New Message',
      'message': 'You have a new message from the admin.',
      'time': '5 hours ago'
    },
    {
      'title': 'Profile Update',
      'message': 'Your profile has been updated.',
      'time': '1 day ago'
    },
    {
      'title': 'Request Approved',
      'message': 'Your donation request has been approved.',
      'time': '2 days ago'
    },
    {
      'title': 'Donation Reminder',
      'message': 'Your scheduled donation is due tomorrow.',
      'time': '3 days ago'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  leading: Icon(Icons.notifications, color: Colors.blueAccent),
                  title: Text(
                    notification['title']!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Text(
                        notification['message']!,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        notification['time']!,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Handle notification tap
                  },
                ),
              Divider(height: 10,),
              ],
            );
          },
        ),
      ),
    );
  }
}
