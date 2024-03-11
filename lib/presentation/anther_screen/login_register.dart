import 'package:flutter/material.dart';
import 'package:unibus/core/app_export.dart';

class LoginOrRegister extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Or Register'),
      ),
      body: Center(
        child:Column(
          mainAxisAlignment:MainAxisAlignment.center ,
          children: [
            Image.asset(ImageConstant.imgLogo,height: 150.adaptSize,width: 150.adaptSize,),
            SizedBox(height: 20.0,),
            _button(onPressed: (){
              Get.toNamed(AppRoutes.switchScreen,arguments: true);
            }, child: Text('Login',style: TextStyle(fontSize: 20.0),)),
            _button(onPressed: (){
              Get.toNamed(AppRoutes.switchScreen,arguments: false);
            }, child: Text('Register',style: TextStyle(fontSize: 20.0),)),
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
