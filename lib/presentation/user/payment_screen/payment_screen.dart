import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPaymentMethod = 'Credit Card';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20.0),
            Text(
              'Total Amount: \$100.00',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40.0),
            DropdownButtonFormField<String>(
              value: _selectedPaymentMethod,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Select Payment Method',
                prefixIcon: Icon(Icons.payment),
              ),
              items: ['Cash', 'Credit Card', 'Apple Pay']
                  .map((String method) {
                return DropdownMenuItem<String>(
                  value: method,
                  child: Text(method),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPaymentMethod = newValue!;
                });
              },
            ),
            SizedBox(height: 20.0),
            if (_selectedPaymentMethod == 'Credit Card')
              Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Card Number',
                      prefixIcon: Icon(Icons.credit_card),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Expiration Date',
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'CVV',
                            prefixIcon: Icon(Icons.security),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            if (_selectedPaymentMethod == 'Apple Pay')
              Column(
                children: [
                  Text(
                    'Use Apple Pay to complete your purchase',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Tap the Apple Pay button to pay securely with your saved cards.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Your device must support Apple Pay and have a valid payment card added.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                ],
              ),
            SizedBox(height: 40.0),
            Text('Pay now and get 2days free',textAlign: TextAlign.center,style: TextStyle(
              fontSize: 18.0
            ),),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // Add your payment processing logic here
                // For example, you can validate card information and process payment
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Payment Processing...')),
                );
                // Simulate a payment delay
                Future.delayed(Duration(seconds: 2), () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Payment Successful')),
                  );
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Pay Now',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



