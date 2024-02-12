import 'package:flutter/material.dart';
import 'package:unibus/core/app_export.dart';
import 'package:unibus/widgets/drawer/comapnyDrawer.dart';

import '../../../core/utils/app_strings.dart';
import '../../../core/utils/image_constant.dart';

// Model class for user requests
class UserRequest {
  final String username;
  final String email;
  final String phone;
  final String address;
  final bool accepted;

  UserRequest({
    required this.username,
    required this.email,
    required this.phone,
    required this.address,
    required this.accepted,
  });
}

class StudentRequestScreen extends StatelessWidget {
  // Sample user requests data
  final List<UserRequest> userRequests = [
    UserRequest(
      username: 'Test User 1',
      email: 'user1@example.com',
      phone: '053-456-7890',
      address: '123 Main St, City',
      accepted: true,
    ),
    UserRequest(
      username: 'Test User 2',
      email: 'user2@example.com',
      phone: '057-654-3210',
      address: '456 Elm St, Town',
      accepted: false,
    ),
    // Add more sample data if needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CompanyDrawer(),
      appBar: AppBar(
        title: Text(AppStrings.Requests), // Utilizing AppStrings
        actions: [
          Image.asset(
            ImageConstant.imgLogo,
            width: 50.0,
          ),
        ],
      ),
      body:DefaultTabController(length: 2, child:Column(
        children: [
          TabBar(tabs:[
            Tab(text: AppStrings.student,),
            Tab(text: AppStrings.employee,),
          ]),
          Expanded(
            child: TabBarView(children: [
              _tab1(),
              _tab2(),
            ])
          )
        ]
      ))
    );
  }

  _tab1()=> ListView.builder(
    itemCount: userRequests.length,
    itemBuilder: (context, index) {
      final userRequest = userRequests[index];
      return Column(
        children: [
          ListTile(
            title: Text(
              userRequest.username,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${AppStrings.email}: ${userRequest.email}'),
                Text('${AppStrings.phone}: ${userRequest.phone}'),
                Text('${AppStrings.address}: ${userRequest.address}'),
                Text('${AppStrings.status}: ${userRequest.accepted ? AppStrings.accepted : AppStrings.rejected}'),
              ],
            ),
            // You can add more actions if needed
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.check, color: Colors.green), // or any other appropriate icon
                  onPressed: () {
                    // Implement logic for accepting user request
                  },
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.red), // or any other appropriate icon
                  onPressed: () {
                    // Implement logic for rejecting user request
                  },
                ),
                IconButton(
                  icon: Icon(Icons.payment, color: Colors.blue), // Payment information button
                  onPressed: () {
                    // Show payment information dialog
                    _showPaymentInfoDialog(context, userRequest);
                  },
                ),
              ],
            ),
          ),
          Divider()
        ],
      );
    },
  );
  _tab2()=> ListView.builder(
    itemCount: userRequests.length,
    itemBuilder: (context, index) {
      final userRequest = userRequests[index];
      return Column(
        children: [
          ListTile(
            title: Text(
              userRequest.username,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${AppStrings.email}: ${userRequest.email}'),
                Text('${AppStrings.phone}: ${userRequest.phone}'),
                Text('${AppStrings.address}: ${userRequest.address}'),
                Text('${AppStrings.status}: ${userRequest.accepted ? AppStrings.accepted : AppStrings.rejected}'),
              ],
            ),
            // You can add more actions if needed
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.check, color: Colors.green), // or any other appropriate icon
                  onPressed: () {
                    // Implement logic for accepting user request
                  },
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.red), // or any other appropriate icon
                  onPressed: () {
                    // Implement logic for rejecting user request
                  },
                ),
                IconButton(
                  icon: Icon(Icons.payment, color: Colors.blue), // Payment information button
                  onPressed: () {
                    // Show payment information dialog
                    _showPaymentInfoDialog(context, userRequest);
                  },
                ),
              ],
            ),
          ),
          Divider()
        ],
      );
    },
  );


  // Method to show payment information dialog
  void _showPaymentInfoDialog(BuildContext context, UserRequest userRequest) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Information'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('User Name: ${userRequest.username}'),
              Text('Payment Type: Subscription'), // Assuming it's a subscription payment
              Text('Payment Date: 2024-02-07'), // Example payment date
              Text('Payment Amount: \$50.00'), // Example payment amount
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
