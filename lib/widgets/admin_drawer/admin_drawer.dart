import 'package:flutter/material.dart';
import 'package:unibus/core/utils/app_strings.dart';
import '../../core/app_export.dart';

class AdminDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
            children: [
              DrawerHeader(child: Image.asset(ImageConstant.imgLogo),
                decoration:  BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey[900]!))
                ),
              ),
              _tab(Icons.person,AppStrings.adminProfile,(){
                Get.toNamed(AppRoutes.adminProfileScreen);
              }),
              _tab(Icons.supervised_user_circle_sharp,AppStrings.userManagement,(){
                Get.toNamed(AppRoutes.adminUsersManagementScreen);
              }),
              _tab(Icons.work,AppStrings.companyManagement,(){
                Get.toNamed(AppRoutes.adminCompaniesManagementScreen);
              }),
              _tab(Icons.logout,AppStrings.logout,(){
                //Get.toNamed(AppRoutes.adminCompaniesManagementScreen);
              }),
            ]
        )
    );
  }

  _tab(icon,title,action)=> Column(
    children: [
      ListTile(
        leading: Icon(icon,color: theme.primaryColor,) ,
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: action,
      ),
      Divider(color: Colors.grey[900],)
    ],
  );
}
