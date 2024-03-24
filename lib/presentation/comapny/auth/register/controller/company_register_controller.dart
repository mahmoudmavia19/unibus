import 'package:flutter/material.dart';
import 'package:unibus/core/constants/constant.dart';
import 'package:unibus/data/remote_data_source/company_remote_data_source.dart';

import '../../../../../core/app_export.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/state_renderer/state_renderer.dart';
import '../../../../../core/utils/state_renderer/state_renderer_impl.dart';
import '../../../../admin/companies_management/model/company_model.dart';
class CompanyRegisterController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  Rx<FlowState> state = Rx<FlowState>(ContentState());
   FlowState get getState => state.value;
    var formKey = GlobalKey<FormState>();
    CompanyRemoteDataSource remoteDataSource = Get.find<CompanyRemoteDataSourceImpl>();
  RxBool obscurePassword = true.obs;
  RxBool accepted = false.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }
  void toggleAccepted(value){
    accepted.value = value ;
  }

  void register() async{
    if(formKey.currentState!.validate()){
      if(passwordValidation(passwordController.text)){
      if(phoneValidation(phoneController.text)){
      if(emailValidation(emailController.text)){
      if(passwordController.text == cPasswordController.text){
      state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
      var company = Company(
        name: usernameController.text,
        email: emailController.text,
        phone: phoneController.text,
      ) ;
      (await remoteDataSource.register(company, passwordController.text)).fold((failure) {
        state.value = ErrorState(StateRendererType.popupErrorState,failure.message);
      },(l) {
        Get.offAllNamed(AppRoutes.companyProfileScreen);
      });
    } else {
      state.value = ErrorState(StateRendererType.popupErrorState,AppStrings.passwordNotMatch);
    }
    } else {
      state.value = ErrorState(StateRendererType.popupErrorState,AppStrings.invalidEmail);
    }
    } else {
      state.value = ErrorState(StateRendererType.popupErrorState,AppStrings.invalidPhone);
    }
    }
    }
  }
}