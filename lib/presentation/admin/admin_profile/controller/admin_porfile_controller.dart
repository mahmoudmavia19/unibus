import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/data/models/admin.dart';
import 'package:unibus/data/remote_data_source/admin_remote_data_source.dart';

import '../../../../core/app_export.dart';

class AdminProfileController extends GetxController {
  Rx<FlowState> state = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
  AdminRemoteDataSource  remoteDataSource = Get.find<AdminRemoteDataSourceImpl>() ;
  AdminModel? adminModel;

  RxBool editMode = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  getProfile () async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.getProfile()).fold((failure) {
      state.value = ErrorState(StateRendererType.fullScreenErrorState, failure.message);
    }, (data) {
      adminModel = data;
      nameController.text = adminModel?.name??'';
      emailController.text = adminModel?.email??'';
      state.value = ContentState();
    });
  }

  updateProfile()async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    adminModel =AdminModel(adminModel!.id,nameController.text , emailController.text) ;
    (await remoteDataSource.updateProfile(adminModel!)).fold((failure) {
      state.value = ErrorState(StateRendererType.fullScreenErrorState, failure.message);
    }, (data)async {
      if(passwordController.text.isNotEmpty){
        (await remoteDataSource.resetPassword(passwordController.text)).fold((failure) {
          state.value = ErrorState(StateRendererType.fullScreenErrorState, failure.message);
        }, (data) {
          state.value = ContentState();
        });
      }
      state.value = ContentState();
    });
  }

  @override
  void onInit() {
    getProfile() ;
    super.onInit();
  }


}