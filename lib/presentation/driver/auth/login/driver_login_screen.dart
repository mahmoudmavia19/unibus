import 'package:flutter/material.dart';

import '../../../../core/app_export.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_form_field.dart';
import 'controller/driver_controller.dart';

class DriverLoginPage extends GetWidget<DriverLoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.driver),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: LoginScreenUI(loginController: controller),
    );
  }
}

class LoginScreenUI extends StatelessWidget {
  final DriverLoginController loginController;

  const LoginScreenUI({Key? key, required this.loginController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(ImageConstant.imgLogo,width: 150,),
             SizedBox(height: 30.0,),
             TextFieldWidget(
              labelText: AppStrings.email,
              controller: loginController.usernameController,
            ),
            SizedBox(height: 20),
            Obx(()=>TextFieldWidget(
                labelText: AppStrings.password,
                obscureText: loginController.obscurePassword.value,
                controller: loginController.passwordController,
                suffixIcon: IconButton(
                  icon: Icon(
                    loginController.obscurePassword.value ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: loginController.togglePasswordVisibility,
                ) ,
              ),
            ),
            SizedBox(height: 20),
            ButtonWidget(onPressed: loginController.login, text:AppStrings.login,),
            ],
        ),
      ),
    );
  }
}

