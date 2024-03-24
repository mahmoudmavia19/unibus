import 'package:flutter/material.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';

import '../../../../core/app_export.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_form_field.dart';
import 'controller/company_register_controller.dart';

class CompanyRegisterPage extends GetWidget<CompanyRegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.company),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Obx(() => controller.getState.getScreenWidget(RegisterScreenUI(loginController:controller),(){})),
    );
  }
}

class RegisterScreenUI extends StatelessWidget {
  final CompanyRegisterController loginController;

  const RegisterScreenUI({Key? key, required this.loginController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: loginController.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(ImageConstant.imgLogo,width: 150,),
               SizedBox(height: 30.0,),
               TextFieldWidget(
                labelText: AppStrings.name,
                controller: loginController.usernameController,
              ),
              SizedBox(height: 20),
              TextFieldWidget(
                labelText: AppStrings.email,
                controller: loginController.emailController,
              ),
              SizedBox(height: 20),
              TextFieldWidget(
                labelText: AppStrings.phone,
                controller: loginController.phoneController,
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
              Obx(()=>TextFieldWidget(
                labelText: AppStrings.cPassword,
                obscureText: loginController.obscurePassword.value,
                controller: loginController.cPasswordController,
                suffixIcon: IconButton(
                  icon: Icon(
                    loginController.obscurePassword.value ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: loginController.togglePasswordVisibility,
                ) ,
              ),
              ),

              Obx(()=> Row(
                  children: [
                    Checkbox(value: loginController.accepted.value, onChanged:(value) {
                      loginController.toggleAccepted(value);
                    },),
                    Text('Accept two days free for each User.')
                  ],
                ),
              ),
              SizedBox(height: 20),
              ButtonWidget(onPressed: loginController.register, text:AppStrings.register,),
             ],
          ),
        ),
      ),
    );
  }
}

