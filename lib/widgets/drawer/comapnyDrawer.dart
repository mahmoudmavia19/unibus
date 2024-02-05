import 'package:flutter/material.dart';
import 'package:unibus/core/utils/app_strings.dart';
import '../../core/app_export.dart';

class CompanyDrawer extends StatelessWidget {

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
              _tab(AppStrings.companyProfile,(){
                Get.toNamed(AppRoutes.companyProfileScreen);
              }),
              _tab(AppStrings.priceManagement,(){
                Get.toNamed(AppRoutes.companyPriceManagementScreen);
              }),
              _tab(AppStrings.driversManagement,(){
                Get.toNamed(AppRoutes.companyDriversManagementScreen);
              }),
              _tab(AppStrings.tripsManagement,(){
                Get.toNamed(AppRoutes.companyTripManagementScreen);
              }),
              _tab(AppStrings.logout,(){
                //Get.toNamed(AppRoutes.adminCompaniesManagementScreen);
              }),
            ]
        )
    );
  }

  _tab(title,action)=> Column(
    children: [
      ListTile(
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: action,
      ),
      Divider(color: Colors.grey[900],)
    ],
  );
}
