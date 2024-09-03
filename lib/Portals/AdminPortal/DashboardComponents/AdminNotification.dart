import 'package:flutter/material.dart';
import 'package:upr_fund_collection/Models/AdminNotificationModal.dart';

class AdminNotificationsPage extends StatelessWidget {
  // Sample list of notifications
  final List<AdminNotification> notifications = [
    AdminNotification(
      title: 'New User Registered',
      content: 'A new user has signed up for your service.',
      timestamp: DateTime.now().subtract(Duration(minutes: 15)),
    ),
    AdminNotification(
      title: 'Server Maintenance Scheduled',
      content: 'Server maintenance will occur at 3:00 AM.',
      timestamp: DateTime.now().subtract(Duration(hours: 2)),
    ),
    AdminNotification(
      title: 'Payment Received',
      content: 'You have received a payment from a user.',
      timestamp: DateTime.now().subtract(Duration(days: 1)),
    ),
    // Add more notifications here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return _buildNotificationCard(notification);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.teal.shade700,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.shade200,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Admin Notifications',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Stay updated with the latest notifications and alerts.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(AdminNotification notification) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(
          notification.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          notification.content,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14,
          ),
        ),
        trailing: Text(
          _formatTimestamp(notification.timestamp),
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    // Format the timestamp to a readable format, e.g., "Aug 30, 2024, 14:30"
    return '${timestamp.day}/${timestamp.month}/${timestamp.year} ${timestamp.hour}:${timestamp.minute}';
  }
}
