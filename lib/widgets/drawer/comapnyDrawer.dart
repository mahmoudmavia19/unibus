import 'package:flutter/material.dart';
import 'package:unibus/core/utils/app_strings.dart';
import '../../core/app_export.dart';

class CompanyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 320,
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
              _tab(Icons.star_rate,AppStrings.driversRateTitle,(){
                Get.offAllNamed(AppRoutes.companyDriversRatingScreen);
              }),
              _tab(Icons.mode_of_travel,AppStrings.tripsManagement,(){
                Get.offAllNamed(AppRoutes.companyTripManagementScreen);
              }),
              _tab(Icons.supervised_user_circle_sharp,AppStrings.Requests,(){
                Get.offAllNamed(AppRoutes.companyStudentRequestScreen);
              }),
              _tab(Icons.chat_bubble,AppStrings.chatCenter,(){
                Get.offAllNamed(AppRoutes.companyChatCenter);
              }),
              _tab(Icons.track_changes,AppStrings.liveTrip,(){
                Get.offAllNamed(AppRoutes.companyLiveTrip);
              }),
              _tab(Icons.logout,AppStrings.logout,(){
                Get.offAndToNamed(AppRoutes.switchScreen);
              }),
            ]
        )
    );
  }

  _tab(icon,title,action)=> Column(
    children: [
      ListTile(
        leading: Icon(icon,color: theme.primaryColor,size: 30,) ,
        title: Text(title,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: action,
      ),
      Divider(color: Colors.grey[900],)
    ],
  );
}
