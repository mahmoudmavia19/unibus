import 'package:flutter/material.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/data/remote_data_source/company_remote_data_source.dart';

import '../../../../core/app_export.dart';
import '../../../admin/companies_management/model/company_model.dart';

class CompanyController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;

  Rx<FlowState> state = Rx<FlowState>(ContentState());
   FlowState get getState => state.value;

   CompanyRemoteDataSource remoteDataSource = Get.find<CompanyRemoteDataSourceImpl>();
  Rx<Company?> company = Rx<Company?>(null);
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

  void getProfile() async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.getProfile()).fold((failure) {
      state.value = ErrorState(StateRendererType.popupErrorState,failure.message);
    },(l) {
      nameController.text = l.name??'';
      emailController.text = l.email??'';
      phoneController.text = l.phone??'';
      company.value = l ;
       state.value = ContentState();
    });
  }

  updateProfile()async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState) ;
    Company _company = Company(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      companyId: company.value!.companyId
    );
    (await remoteDataSource.updateProfile(_company)).fold((failure) {
      state.value = ErrorState(StateRendererType.popupErrorState,failure.message);
    }, (l)async {
      if(passwordController.text.isNotEmpty){
        (await remoteDataSource.resetPassword(passwordController.text)).fold((l) {
          state.value  = ErrorState(StateRendererType.popupErrorState,l.message);;
        }, (r){
          state.value = ContentState();
        }) ;
      }
      state.value = ContentState();
    });

  }
}