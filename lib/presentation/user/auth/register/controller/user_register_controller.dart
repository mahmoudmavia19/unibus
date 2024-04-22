import 'package:flutter/material.dart';
import 'package:unibus/core/constants/constant.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer.dart';
import 'package:unibus/data/remote_data_source/remote_data_source.dart';
import 'package:unibus/presentation/admin/users_manage/model/user_model.dart';

import '../../../../../core/app_export.dart';
import '../../../../../core/utils/state_renderer/state_renderer_impl.dart';
class UseRegisterController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  Rx<FlowState> state = Rx<FlowState>(ContentState());
   FlowState get getState => state.value;
   RemoteDataSource remoteDataSource = Get.find<RemoteDataSourceImpl>() ;
   var formKey = GlobalKey<FormState>();
  RxBool obscurePassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void register() async{
    if(formKey.currentState!.validate()) {
      if(passwordValidation(passwordController.text)) {
      if (phoneValidation(phoneController.text)) {
        if (emailValidation(emailController.text)) {
          if (nameValidation(usernameController.text)) {
            if (passwordController.text == cPasswordController.text) {
              state.value = LoadingState(
                  stateRendererType: StateRendererType.fullScreenLoadingState);
              var user = UserModel(
                name: usernameController.text,
                email: emailController.text,
                phone: phoneController.text,
              );
              (await remoteDataSource.register( 
                  user, passwordController.text
              )).fold((l) {
                state.value = ErrorState(
                    StateRendererType.popupErrorState,
                    l.message
                );
              }, (r) {
                Get.offAllNamed(AppRoutes.userMain);
              });
            } else {
              state.value = ErrorState(
                  StateRendererType.popupErrorState,
                  'Password does not match'
              );
            }
          } else {
            state.value = ErrorState(
                StateRendererType.popupErrorState,
                'Please enter a valid name'
            );
          }
        } else {
          state.value = ErrorState(
              StateRendererType.popupErrorState,
              'Please enter a valid email'
          );
        }
      } else {
        state.value = ErrorState(
            StateRendererType.popupErrorState,
            'Please enter a valid phone'
        );
      }
      } else {
        state.value = ErrorState(
            StateRendererType.popupErrorState,
            'Please enter a valid password'
        );
      }
    }
  }
}