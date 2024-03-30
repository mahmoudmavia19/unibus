import 'package:flutter/material.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/presentation/user/payment_screen/controller/payment_controller.dart';

import '../../../core/app_export.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPaymentMethod = 'Credit Card';
  PaymentController _paymentController = Get.find<PaymentController>();

  @override
  void initState() { 
    _paymentController.methodController.text = _selectedPaymentMethod;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child:Obx(()=>_paymentController.state.value.getScreenWidget(_body(), (){})),
      ),
    );
  }
  _body()=> Form(
    key: _paymentController.formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(height: 20.0),
        Text(
          'Total Amount: \$${_paymentController.price.price}',
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a payment method';
            }
            return null;
          },
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
              _paymentController.methodController.text = _selectedPaymentMethod;
            });
          },
        ),
        SizedBox(height: 20.0),
        if (_selectedPaymentMethod == 'Credit Card')
          Column(
            children: [
              TextFormField(
                controller: _paymentController.cardNumberController,
                decoration: InputDecoration(
                  labelText: 'Card Number',
                  prefixIcon: Icon(Icons.credit_card),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your card number';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your expiration date';
                        }
                        return null;
                      },
                      controller: _paymentController.expiryDateController,
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
                      controller: _paymentController.cvvController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your CVV';
                        }
                        return null;
                      },
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
            _paymentController.subscribeToTrip();
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
  );
}



