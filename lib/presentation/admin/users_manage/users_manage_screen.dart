import 'package:flutter/material.dart';
import 'package:unibus/core/app_export.dart';
import 'package:unibus/core/utils/app_strings.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/presentation/admin/users_manage/controller/users_controller.dart';
import 'package:unibus/presentation/admin/users_manage/model/user_model.dart';
import '../../../widgets/drawer/admin_drawer.dart';

class UsersManagementScreen extends GetWidget<UsersController> {

/*  final List<UserModel> users = [
    UserModel(
      name: 'User1',
      userId: '1',
      address: '123 Street',
      phone: '1234567890',
      email: 'user@example.com',
     ),
    UserModel(
      name: 'User2',
      userId: '2',
      address: '123 Street',
      phone: '1234567890',
      email: 'user2@example.com',
     ),
    // Add more users here as needed
  ];*/

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
      body: Obx(()=> SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: controller.state.value.getScreenWidget(_body(), (){
            controller.getUsers();
          })
        ),
      ),
    );
  }

  _body()=> Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      ListView.builder(
        shrinkWrap: true,
        itemCount: controller.users.length,
        itemBuilder: (context, index) {
          return _buildUserCard(user: controller.users[index], index: index);
        },
      ),
    ],
  );

  Widget _buildUserCard({required UserModel user ,required int index}) {
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
       //     Text('${AppStrings.userId}: ${user.userId}'),
            Text('${AppStrings.address}: ${user.address}'),
            Text('${AppStrings.phone}: ${user.phone}'),
            Text('${AppStrings.email}: ${user.email}'),
           ],
        ),
        trailing: IconButton(
          icon: controller.users[index].blocked?Icon(Icons.remove_circle_outline, color: Colors.green):Icon(Icons.block, color: Colors.red),
          onPressed: () {
            controller.blockUser(user.userId!, index);
            },
        ),
      ),
    );
  }
}
