import 'package:flutter/material.dart';
import 'package:unibus/data/remote_data_source/company_remote_data_source.dart';

import '../../../../../core/app_export.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/state_renderer/state_renderer.dart';
import '../../../../../core/utils/state_renderer/state_renderer_impl.dart';
class CompanyLoginController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Rx<FlowState> state = Rx<FlowState>(ContentState());
   FlowState get getState => state.value;
   CompanyRemoteDataSource remoteDataSource = Get.find<CompanyRemoteDataSourceImpl>();
  RxBool obscurePassword = true.obs;
  var formKey = GlobalKey<FormState>();
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void login() async{
    if(formKey.currentState!.validate()){
      state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
      (await remoteDataSource.login(usernameController.text, passwordController.text)).fold((failure) {
        state.value = ErrorState(StateRendererType.popupErrorState,failure.message);
      },(l) async{
        if(l){
           (await remoteDataSource.getProfile()).fold((l) => null, (r){
             if(r.blocked){
               state.value = ErrorState(
                 StateRendererType.popupErrorState,
                 "Your account is blocked"
               );
             }else {
               Get.offAllNamed(AppRoutes.companyProfileScreen);
             }
           });
        } else {
          state.value = ErrorState(StateRendererType.popupErrorState,AppStrings.noCompany);
        }
      });
    }
  }
}