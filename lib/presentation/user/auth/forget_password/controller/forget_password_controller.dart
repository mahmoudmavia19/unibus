import 'package:flutter/material.dart';

import '../../../../../core/app_export.dart';
import '../../../../../core/utils/state_renderer/state_renderer.dart';
import '../../../../../core/utils/state_renderer/state_renderer_impl.dart';
import '../../../../../data/remote_data_source/admin_remote_data_source.dart';
class ForgetPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Rx<FlowState> state = Rx<FlowState>(ContentState());
   FlowState get getState => state.value;
  RxBool obscurePassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void forgetPassword() async{
     state.value  = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
     (await Get.find<AdminRemoteDataSourceImpl>().forgetPassword(emailController.text)).fold((failure) {
       state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
     }, (data) {
       state.value = SuccessState(StateRendererType.fullScreenSuccessState, 'Check your email to reset your password');
     });
  }
}