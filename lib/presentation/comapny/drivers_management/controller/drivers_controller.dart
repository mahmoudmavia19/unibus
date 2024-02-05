import 'package:flutter/material.dart';
import 'package:unibus/core/utils/app_strings.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';

import '../../../../core/app_export.dart';
 import '../model/driver.dart';

class DriverController extends GetxController {
   Rx<FlowState> state = Rx<FlowState>(EmptyState(''));
   final GlobalKey<FormState> addFormKey = GlobalKey<FormState>();
   final GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
  var drivers =[];/* <Driver>[
    Driver(name: 'Driver1', address: 'Address 1', phone: '0534567890', email: 'driver1@example.com', password: 'password1'),
    Driver(name: 'Driver2', address: 'Address 2', phone: '0576543210', email: 'driver2@example.com', password: 'password2'),
  ].obs;*/

  void addDriver(Driver driver) {
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    drivers.add(driver);
    state.value = SuccessState(StateRendererType.popupSuccessState, AppStrings.successAdded);
  }

  void editDriver(int index, Driver driver) {
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    drivers[index] = driver;
    state.value = SuccessState(StateRendererType.popupSuccessState, AppStrings.successUpdated);

  }

  void deleteDriver(int index) {
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);

    drivers.removeAt(index);
    state.value = SuccessState(StateRendererType.popupSuccessState, AppStrings.successDeleted);

  }
}