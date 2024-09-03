import 'package:flutter/material.dart';

class DonorDonationRequestPage extends StatelessWidget {
  // Sample data for donation requests
  final List<Map<String, dynamic>> donationRequests = [
    {
      'id': '1',
      'requestedBy': 'John Doe',
      'amount': 150,
      'status': 'Pending',
      'progress': 0.0,
    },
    {
      'id': '2',
      'requestedBy': 'Jane Smith',
      'amount': 300,
      'status': 'Approved',
      'progress': 0.7,
    },
    {
      'id': '3',
      'requestedBy': 'Mike Johnson',
      'amount': 200,
      'status': 'Rejected',
      'progress': 0.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: donationRequests.length,
        itemBuilder: (context, index) {
          final request = donationRequests[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Requested By: ${request['requestedBy']}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade900,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Amount: \$${request['amount']}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Status: ${request['status']}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _getStatusColor(request['status']),
                    ),
                  ),
                  if (request['status'] == 'Approved') ...[
                    SizedBox(height: 16),
                    Text(
                      'Progress:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade800,
                      ),
                    ),
                    SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: request['progress'],
                      backgroundColor: Colors.teal.shade100,
                      color: Colors.teal.shade700,
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${(request['progress'] * 100).toInt()}% of the goal raised',
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                    ),
                  ],
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red.shade700),
                      onPressed: () {
                        _deleteRequest(request['id']);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Function to get the color based on status
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green.shade700;
      case 'Rejected':
        return Colors.red.shade700;
      default:
        return Colors.orange.shade700;
    }
  }

  // Function to delete a donation request (to be implemented)
  void _deleteRequest(String id) {
    // Handle the delete request logic here, such as removing it from the database.
    print('Request with ID $id has been deleted');
  }
}
