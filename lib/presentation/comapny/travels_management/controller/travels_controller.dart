import 'package:flutter/material.dart';

import '../../../../core/app_export.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/state_renderer/state_renderer.dart';
import '../../../../core/utils/state_renderer/state_renderer_impl.dart';
import '../model/trip.dart';

class TripController extends GetxController {
  Rx<FlowState> state = Rx<FlowState>(EmptyState(''));
  final GlobalKey<FormState> addFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
  var trips = <Trip>[];

  void addTrip(Trip trip) {
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    trips.add(trip);
    state.value = SuccessState(StateRendererType.popupSuccessState, AppStrings.successAdded);
  }

  void editTrip(int index, Trip trip) {
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    trips[index] = trip;
    state.value = SuccessState(StateRendererType.popupSuccessState, AppStrings.successUpdated);
  }

  void deleteTrip(int index) {
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    trips.removeAt(index);
    state.value = SuccessState(StateRendererType.popupSuccessState, AppStrings.successDeleted);
  }
}
