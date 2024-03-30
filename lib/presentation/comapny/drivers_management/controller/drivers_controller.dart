import 'package:flutter/material.dart';
import 'package:unibus/core/utils/app_strings.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/data/remote_data_source/company_remote_data_source.dart';

import '../../../../core/app_export.dart';
 import '../model/driver.dart';

class DriverController extends GetxController {
   Rx<FlowState> state = Rx<FlowState>(ContentState());
   final GlobalKey<FormState> addFormKey = GlobalKey<FormState>();
   final GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
  var drivers = <Driver>[].obs  ;
  CompanyRemoteDataSource remoteDataSource = Get.find<CompanyRemoteDataSourceImpl>();
  void addDriver(Driver driver,String password) async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.addDriver(driver, password)).fold(
      (failure) {
        state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
      } , (r)async{
        await getDrivers() ;
        state.value = SuccessState(StateRendererType.popupSuccessState, AppStrings.successAdded);
      }
    );
  }
  onInit() {
    getDrivers();
    super.onInit();
  }
  Future<void> getDrivers() async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.getDrivers()).fold(
      (failure) {
        state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
      } , (r){
        print(r.length);
        drivers.value = r;
        state.value = ContentState();
      }
    );
  }

  void editDriver(Driver driver) async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.editDriver(driver)).fold(
      (failure) {
        state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
      } , (r)async{
        await getDrivers() ;
        state.value = SuccessState(StateRendererType.popupSuccessState, AppStrings.successUpdated);
      }
    );
  }

  void deleteDriver(Driver driver) async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.deleteDriver(driver)).fold(
      (failure) {
        state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
      } , (r)async{
        await getDrivers() ;
        state.value = SuccessState(StateRendererType.popupSuccessState, AppStrings.successDeleted);
      }
    );

  }
}