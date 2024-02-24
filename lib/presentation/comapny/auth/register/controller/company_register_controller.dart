import 'package:flutter/material.dart';

import '../../../../../core/app_export.dart';
class CompanyRegisterController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
/*  Rx<FlowState> state = Rx<FlowState>(ContentState());
   FlowState get getState => state.value;*/
  RxBool obscurePassword = true.obs;
  RxBool accepted = false.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }
  void toggleAccepted(value){
    accepted.value = value ;
  }

  void login() async{
    //Get.toNamed(AppRoutes.d);
  }
}