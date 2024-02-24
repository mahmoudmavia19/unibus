import 'package:flutter/material.dart';

import '../../../../../core/app_export.dart';
class ForgetPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
/*  Rx<FlowState> state = Rx<FlowState>(ContentState());
   FlowState get getState => state.value;*/
  RxBool obscurePassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void login() async{
    Get.toNamed(AppRoutes.userMain);
  }
}