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
              _tab(Icons.work_outlined,AppStrings.companyProfile,(){
                Get.offAllNamed(AppRoutes.companyProfileScreen);
              }),
              _tab(Icons.price_change,AppStrings.priceManagement,(){
                Get.offAllNamed(AppRoutes.companyPriceManagementScreen);
              }),
              _tab(Icons.person,AppStrings.driversManagement,(){
                Get.offAllNamed(AppRoutes.companyDriversManagementScreen);
              }),
              _tab(Icons.mode_of_travel,AppStrings.tripsManagement,(){
                Get.offAllNamed(AppRoutes.companyTripManagementScreen);
              }),
              _tab(Icons.supervised_user_circle_sharp,AppStrings.StudentsRequests,(){
                Get.offAllNamed(AppRoutes.companyStudentRequestScreen);
              }),
              _tab(Icons.chat_bubble,AppStrings.chatCenter,(){
                Get.offAllNamed(AppRoutes.companyChatCenter);
              }),
              _tab(Icons.track_changes,AppStrings.liveTrip,(){
                Get.offAllNamed(AppRoutes.companyLiveTrip);
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
