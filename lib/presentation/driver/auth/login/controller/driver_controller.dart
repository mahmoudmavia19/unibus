import 'package:flutter/material.dart';
import 'package:unibus/data/remote_data_source/driver_remote_data_source.dart';

import '../../../../../core/app_export.dart';
import '../../../../../core/constants/constant.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/state_renderer/state_renderer.dart';
import '../../../../../core/utils/state_renderer/state_renderer_impl.dart';
class DriverLoginController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Rx<FlowState> state = Rx<FlowState>(ContentState());
   FlowState get getState => state.value;
  RxBool obscurePassword = true.obs;
   var formKey = GlobalKey<FormState>();
   DriverRemoteDataSource remoteDataSource = Get.find<DriverRemoteDataSourceImpl>();
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void login() async{
    if(formKey.currentState!.validate()){
        state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
        (await remoteDataSource.login(usernameController.text, passwordController.text)).fold((failure) {
          state.value = ErrorState(StateRendererType.popupErrorState,failure.message);
        },(l) {
          if(l){
            Get.offAllNamed(AppRoutes.driverTripsTableScreen);
          } else {
            state.value = ErrorState(StateRendererType.popupErrorState,AppStrings.noDriver);
          }
        });
    }
  }
}