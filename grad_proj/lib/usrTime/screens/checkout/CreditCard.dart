import 'package:flutter/material.dart';

class CreditCardPage extends StatefulWidget {
  const CreditCardPage({Key? key}) : super(key: key);

  @override
  _CreditCardPageState createState() => _CreditCardPageState();
}

class _CreditCardPageState extends State<CreditCardPage> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardHolderController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Credit Card Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('Credit Card Number', cardNumberController),
            SizedBox(height: 16),
            _buildTextField('Cardholder Name', cardHolderController),
            SizedBox(height: 16),
            _buildTextField('Expiry Date', expiryDateController),
            SizedBox(height: 16),
            _buildTextField('CVV', cvvController),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Handle credit card submission here
                print('Credit card submitted');
                print('Card Number: ${cardNumberController.text}');
                print('Cardholder Name: ${cardHolderController.text}');
                print('Expiry Date: ${expiryDateController.text}');
                print('CVV: ${cvvController.text}');
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}
