import 'package:unibus/core/utils/state_renderer/state_renderer.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/data/remote_data_source/driver_remote_data_source.dart';
import 'package:unibus/presentation/comapny/travels_management/model/trip.dart';

import '../../../../core/app_export.dart';

class TripsTableController extends GetxController {
  Rx<FlowState> state = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
  DriverRemoteDataSource remoteDataSource = Get.find<DriverRemoteDataSourceImpl>();
  List<Trip> trips = [];
  RxList<Trip> filteredTrips = <Trip>[].obs;
  List<String> days = [];
  void getTrips() async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.getTrips()).fold((failure) {
      state.value = ErrorState(StateRendererType.popupErrorState,failure.message);
    },(data) {
      trips = data;
      filterTrips();
      state.value = ContentState();
    });
  }

  filterTrips() {
    filteredTrips.value = trips.where((element){
      for(var i=0;i<element.days!.length;i++){
        if(!days.contains(element.days![i])){
          return true;
        }
      }
      return false;
    }).toList();
  }

  @override
  void onInit() {
    getTrips();
    super.onInit();
  }
}