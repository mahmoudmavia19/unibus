import 'package:flutter/material.dart';

import '../../../../../core/app_export.dart';
class UseRegisterController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
/*  Rx<FlowState> state = Rx<FlowState>(ContentState());
   FlowState get getState => state.value;*/
  RxBool obscurePassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void login() async{
    //Get.toNamed(AppRoutes.d);
  }
}