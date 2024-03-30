import 'package:flutter/material.dart';
import 'package:unibus/data/remote_data_source/company_remote_data_source.dart';
import 'package:unibus/presentation/admin/companies_management/companies_management_screen.dart';

import '../../../../core/app_export.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/state_renderer/state_renderer.dart';
import '../../../../core/utils/state_renderer/state_renderer_impl.dart';
import '../../drivers_management/model/driver.dart';
import '../model/trip.dart';

class TripController extends GetxController {
  Rx<FlowState> state = Rx<FlowState>(EmptyState(''));
  final GlobalKey<FormState> addFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
  CompanyRemoteDataSource remoteDataSource = Get.find<CompanyRemoteDataSourceImpl>();
  var trips = <Trip>[];
  RxList<Driver> drivers  = <Driver>[].obs;

  Future<void>getDrivers() async {
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.getDrivers()).fold(
            (failure) {
          state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
        }, (r){
      drivers.value = r;
      state.value = ContentState();
    }
    );
  }
  Future<void>getTrips() async {
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.getTrips()).fold(
      (failure) {
        state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
      }, (r){
        trips = r;
        state.value = ContentState();
      }
    );
  }
  @override
  void onInit() async{
    await getDrivers();
    await getTrips();
    super.onInit();
  }

  void addTrip(Trip trip) async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.addTrip(trip)).fold(
      (failure) {
        state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
      }, (r)async{
       await getTrips();
        state.value = SuccessState(StateRendererType.popupSuccessState, AppStrings.successAdded);
      }
    );
  }

  void editTrip(int index, Trip trip) async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.updateTrip(trip)).fold(
      (failure) {
        state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
      }, (r){
        state.value = SuccessState(StateRendererType.popupSuccessState, AppStrings.successEdited);
      }
    );
  }

  void deleteTrip(Trip trip) async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.deleteTrip(trip)).fold(
      (failure) {
        state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
      }, (r)async{
        await getTrips();
        state.value = SuccessState(StateRendererType.popupSuccessState, AppStrings.successDeleted);
      }
    );
  }
}
