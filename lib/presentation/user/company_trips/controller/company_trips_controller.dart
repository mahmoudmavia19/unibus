import 'package:unibus/core/utils/state_renderer/state_renderer.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/data/remote_data_source/remote_data_source.dart';
import 'package:unibus/presentation/admin/companies_management/model/company_model.dart';
import 'package:unibus/presentation/comapny/price_management/model/price.dart';
import 'package:unibus/presentation/comapny/travels_management/model/trip.dart';

import '../../../../core/app_export.dart';

class CompanyTripsController extends GetxController {
  Rx<FlowState> state = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
  RemoteDataSource remoteDataSource = Get.find<RemoteDataSourceImpl>();
  RxList<Trip> trips = RxList<Trip>([]);
  Company company = Get.arguments[0];
  Price price = Get.arguments[1];
  getTrips()async{
     state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
     trips.clear();
     (await remoteDataSource.getTrips(company.companyId!,price.uid!)).fold((l) {
       state.value = ErrorState(
         StateRendererType.fullScreenErrorState,
         l.message
       );
     }, (r)async{
      for(var trip in r){
        (await remoteDataSource.getDriver(trip.driver!)).fold((l){

        }, (r){
          trip.driverModel = r;
        });
        trips.add(trip);
      }
       state.value = ContentState();
     });
  }

  @override
  void onInit() {
    getTrips();
    super.onInit();
  }

}