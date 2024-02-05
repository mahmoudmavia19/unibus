import 'package:flutter/material.dart';
import 'package:unibus/core/app_export.dart';
import 'package:unibus/core/utils/app_strings.dart';
import 'package:unibus/presentation/admin/users_manage/model/user_model.dart';
import '../../../widgets/drawer/admin_drawer.dart';

class UsersManagementScreen extends StatelessWidget {
  final List<UserModel> users = [
    UserModel(
      name: 'User1',
      userId: '1',
      address: '123 Street',
      phone: '1234567890',
      email: 'user@example.com',
      password: '********',
    ),
    UserModel(
      name: 'User2',
      userId: '2',
      address: '123 Street',
      phone: '1234567890',
      email: 'user2@example.com',
      password: '********',
    ),
    // Add more users here as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawer(),
      appBar: AppBar(
        title: Text(AppStrings.userManagement),
        actions: [
          Image.asset(
            ImageConstant.imgLogo,
            width: 50.0,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: users.length,
              itemBuilder: (context, index) {
                return _buildUserCard(user: users[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard({required UserModel user}) {
    return Card(
      child: ListTile(
        title: Text(
          'Name: ${user.name}',
          style: TextStyle(
            color: theme.primaryColor,
            fontSize: 18.0,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${AppStrings.userId}: ${user.userId}'),
            Text('${AppStrings.address}: ${user.address}'),
            Text('${AppStrings.phone}: ${user.phone}'),
            Text('${AppStrings.email}: ${user.email}'),
            Text('${AppStrings.password}:${user.password}'),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.block, color: Colors.red),
          onPressed: () {
            // Implement logic to block user
          },
        ),
      ),
    );
  }
}
