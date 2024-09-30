import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:upr_fund_collection/PaymentRelated/PaymentMaking.dart';

class PaymentMethodSelector extends StatefulWidget {
  @override
  _PaymentMethodSelectorState createState() => _PaymentMethodSelectorState();
}

class _PaymentMethodSelectorState extends State<PaymentMethodSelector> {
  final TextEditingController _amountController = TextEditingController();
  String? _selectedPaymentMethod;

  void _processPayment() {
    if (_selectedPaymentMethod == null || _amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a payment method and enter an amount')),
      );
      return;
    }

    // Handle payment processing here
    // You can integrate actual payment gateways like Stripe, PayPal, etc.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Processing ${_selectedPaymentMethod} payment...')),
    );

    // Clear the form after processing
    _amountController.clear();
    setState(() {
      _selectedPaymentMethod = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donate Now'),
        backgroundColor: Colors.teal.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Amount:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Amount',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Select Payment Method:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ListTile(
              leading: Icon(FontAwesomeIcons.creditCard),
              title: Text('Credit/Debit Card'),
              trailing: Radio<String>(
                value: 'Credit/Debit Card',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                },
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.paypal),
              title: Text('PayPal'),
              trailing: Radio<String>(
                value: 'PayPal',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                },
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.googleWallet),
              title: Text('Google Pay'),
              trailing: Radio<String>(
                value: 'Google Pay',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                },
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.applePay),
              title: Text('Apple Pay'),
              trailing: Radio<String>(
                value: 'Apple Pay',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: ()async{

                },
                child: Text('Donate Now'),
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
    );
  }
}
