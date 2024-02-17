import 'package:flutter/material.dart';
import 'package:unibus/core/app_export.dart';

class SwitchScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Switch Screen'),
      ),
      body: Center(
        child:Column(
          mainAxisAlignment:MainAxisAlignment.center ,
          children: [
            Image.asset(ImageConstant.imgLogo,height: 100.adaptSize,width: 100.adaptSize,),
            TextButton(onPressed: (){
              Get.toNamed(AppRoutes.adminProfileScreen);
            }, child: Text('Admin',style: TextStyle(fontSize: 20.0),)),
            TextButton(onPressed: (){
              Get.toNamed(AppRoutes.companyProfileScreen);
            }, child: Text('Company',style: TextStyle(fontSize: 20.0),)),
            TextButton(onPressed: (){
              Get.offAndToNamed(AppRoutes.userMain);
            }, child: Text('User',style: TextStyle(fontSize: 20.0),)),
          ]
        ),
      )
    );
  }
}
