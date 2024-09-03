import 'package:flutter/material.dart';

class AdsaHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADSA Dashboard'),
        backgroundColor: Colors.teal.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            // Menu options
            _buildMenuOption(
              context: context,
              icon: Icons.view_agenda,
              label: 'Manage Views',
              onTap: () {
                // Navigate to Manage Views page
              },
            ),
            _buildMenuOption(
              context: context,
              icon: Icons.person,
              label: 'User Management',
              onTap: () {
                // Navigate to User Management page
              },
            ),
            _buildMenuOption(
              context: context,
              icon: Icons.notifications,
              label: 'Notifications',
              onTap: () {
                // Navigate to Notifications page
              },
            ),
            _buildMenuOption(
              context: context,
              icon: Icons.analytics,
              label: 'Reports',
              onTap: () {
                // Navigate to Reports page
              },
            ),
            _buildMenuOption(
              context: context,
              icon: Icons.settings,
              label: 'Settings',
              onTap: () {
                // Navigate to Settings page
              },
            ),
            _buildMenuOption(
              context: context,
              icon: Icons.help,
              label: 'Support',
              onTap: () {
                // Navigate to Support page
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuOption({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 4.0,
        shadowColor: Colors.teal.withOpacity(0.3),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: Colors.teal.shade600,
              ),
              SizedBox(height: 16.0),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
