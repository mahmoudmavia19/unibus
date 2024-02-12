import 'package:flutter/material.dart';

import '../../../../core/app_export.dart';

class UserProfileController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;

  var isEditMode = false.obs;

  @override
  void onInit() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void toggleEditMode() {
    isEditMode.value = !isEditMode.value;
  }
}