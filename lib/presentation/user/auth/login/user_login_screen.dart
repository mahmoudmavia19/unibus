import 'package:flutter/material.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';

import '../../../../core/app_export.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_form_field.dart';
import 'controller/user_controller.dart';

class UserLoginPage extends GetWidget<UserLoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.user),
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
  final UserLoginController loginController;

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
             Obx(() => loginController.getState.getScreenWidget(_body(), (){})) ,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('You don\'t have account?'),
                TextButton(onPressed: (){
                  Get.toNamed(AppRoutes.userRegisterScreen);
                }, child: Text('Register.'))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('I Forget Password!'),
                TextButton(onPressed: (){
                  Get.toNamed(AppRoutes.forgetPasswordScreen);
                }, child: Text('Click Here.'))
              ],
            ),
           ],
        ),
      ),
    );
  }

  _body()=>Form(
    key: loginController.formKey,
    child: Column(
      children: [
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
  );
}

