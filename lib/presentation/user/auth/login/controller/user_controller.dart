import 'package:flutter/material.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer.dart';
import 'package:unibus/data/remote_data_source/remote_data_source.dart';
import '../../../../../core/app_export.dart';
import '../../../../../core/utils/state_renderer/state_renderer_impl.dart';
class UserLoginController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Rx<FlowState> state = Rx<FlowState>(ContentState());
  RemoteDataSource remoteDataSource = Get.find<RemoteDateSourceImpl>() ;
   FlowState get getState => state.value;
  RxBool obscurePassword = true.obs;
  var formKey = GlobalKey<FormState>();

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void login() async{
    if(formKey.currentState!.validate()) {
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.login(usernameController.text, passwordController.text)).fold(
      (failure) {
        state.value = ErrorState(
        StateRendererType.popupErrorState,
        failure.message
        );
      },(r){
        if(r) {
          Get.offAllNamed(AppRoutes.userMain);
        }
      else {
          state.value = ErrorState(StateRendererType.popupErrorState, 'You are not user');
        }
    });
  }
  }
}