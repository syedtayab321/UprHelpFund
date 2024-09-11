import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';

class DonorFeedbackPage extends StatefulWidget {
  @override
  _DonorFeedbackPageState createState() => _DonorFeedbackPageState();
}

class _DonorFeedbackPageState extends State<DonorFeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();
  double _rating = 3.0;

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      // Process the feedback (e.g., send it to the server or save it locally)
      print('Name: ${_nameController.text}');
      print('Email: ${_emailController.text}');
      print('Feedback: ${_feedbackController.text}');
      print('Rating: $_rating');

      // Show a success message or navigate to another page
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Feedback submitted successfully!')),
      );

      // Clear the form
      _nameController.clear();
      _emailController.clear();
      _feedbackController.clear();
      setState(() {
        _rating = 3.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(title: 'Give Feedback',color:Colors.white),
        backgroundColor: Colors.teal.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Your Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
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
    );
  }
}
