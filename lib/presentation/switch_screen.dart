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
            Image.asset(ImageConstant.imgLogo,height: 150.adaptSize,width: 150.adaptSize,),
            SizedBox(height: 20.0,),
            _button(onPressed: (){
              Get.toNamed(AppRoutes.adminLoginScreen);
            }, child: Text('Admin',style: TextStyle(fontSize: 20.0),)),
            _button(onPressed: (){
              Get.toNamed(AppRoutes.companyLoginScreen);
            }, child: Text('Company',style: TextStyle(fontSize: 20.0),)),
            _button(onPressed: (){
              Get.toNamed(AppRoutes.userLoginScreen);
              }, child: Text('User',style: TextStyle(fontSize: 20.0),)),
            _button(onPressed: (){
              Get.toNamed(AppRoutes.driverLoginScreen);

            }, child: Text('Driver',style: TextStyle(fontSize: 20.0),)),
          ]
        ),
      )
    );
  }

  _button({required VoidCallback onPressed,required Widget child}){
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: SizedBox(
        width: 150.0,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: child,
          )
        ),
      ),
    );
  }
}
