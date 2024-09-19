import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:upr_fund_collection/CustomWidgets/Snakbar.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';

class DonorFeedbackPage extends StatefulWidget {
  @override
  _DonorFeedbackPageState createState() => _DonorFeedbackPageState();
}

class _DonorFeedbackPageState extends State<DonorFeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _feedbackController = TextEditingController();
  double _rating = 3.0;
  User? user = FirebaseAuth.instance.currentUser;

  void _submitFeedback() async {
    if (_formKey.currentState!.validate()) {
      DocumentSnapshot<Map<String,dynamic>> UserData = await FirebaseFirestore.instance.collection('Users').doc(user!.uid).get();
      try {
        // Save feedback to Firestore
        await FirebaseFirestore.instance.collection('Feedback').add({
          'userId': user!.uid,
          'UserName':UserData['name'],
          'Profession':UserData['role'],
          'feedback': _feedbackController.text,
          'rating': _rating,
          'timestamp': FieldValue.serverTimestamp(),
        });

        showSuccessSnackbar('Feedback submitted successfully');

        // Clear the form
        _feedbackController.clear();
        setState(() {
          _rating = 3.0;
        });
      } catch (e) {
        showErrorSnackbar('Failed to submit feedback: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(title: 'Give Feedback', color: Colors.white),
        backgroundColor: Colors.teal.shade700,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(height: 16),
                TextFormField(
                  controller: _feedbackController,
                  decoration: InputDecoration(
                    labelText: 'Your Feedback',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide your feedback';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Rate Us:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                RatingBar.builder(
                  initialRating: _rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
                SizedBox(height: 32),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitFeedback,
                    child: Text('Submit Feedback'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
