import 'package:flutter/material.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/data/remote_data_source/remote_data_source.dart';

import '../../../../core/app_export.dart';
import '../../../admin/users_manage/model/user_model.dart';

class UserProfileController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  Rx<FlowState> flowState = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
  RemoteDataSource remoteDataSource = Get.find<RemoteDataSourceImpl>();
  Rx<UserModel?> user = Rx<UserModel?>(null);


  var isEditMode = false.obs;

  @override
  void onInit() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    getProfile();
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

  getProfile()async{
    flowState.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.getProfile()).fold((l) {
      flowState.value = ErrorState(StateRendererType.fullScreenErrorState,l.message);
    }, (r) {
      user.value = r;
      nameController.text = user.value!.name!;
      emailController.text = user.value!.email!;
      phoneController.text = user.value!.phone!;
      flowState.value = ContentState();
    });
  }

  updateProfile()async{
   flowState.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
   (await remoteDataSource.updateProfile(UserModel(
     name: nameController.text,
     email: emailController.text,
     phone: phoneController.text,
     address: user.value!.address,
     userId: user.value!.userId,
     userType: 0,
   ))).fold((l) {
     flowState.value = ErrorState(StateRendererType.fullScreenErrorState,l.message);
   }, (r) async{
     if(passwordController.text.isNotEmpty){
       (await remoteDataSource.resetPassword(passwordController.text)).fold((l) {
         flowState.value = ErrorState(StateRendererType.popupErrorState,l.message);
       }, (r) {
         flowState.value = SuccessState(StateRendererType.popupSuccessState,'Successfully update profile');
       });
     }else{
       flowState.value = SuccessState(StateRendererType.popupSuccessState,'Successfully update profile');
     }
   });
  }
}