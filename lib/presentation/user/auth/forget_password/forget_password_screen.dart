import 'package:flutter/material.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import '../../../../core/app_export.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_form_field.dart';
import 'controller/forget_password_controller.dart';

class ForgetPasswordPage extends GetWidget<ForgetPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.forgetPassword),
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
  final ForgetPasswordController loginController;

  const LoginScreenUI({Key? key, required this.loginController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(()=>SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: loginController.state.value.getScreenWidget(_body(), (){}),
        ),
      ),
    );
  }

  _body()=>Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Image.asset(ImageConstant.imgLogo,width: 150,),
      SizedBox(height: 30.0,),
      TextFieldWidget(
        labelText: AppStrings.email,
        controller: loginController.emailController,
      ),
      SizedBox(height: 20),
      ButtonWidget(onPressed:(){
        loginController.forgetPassword();
      }, text:AppStrings.send,)
    ],
  );
}

