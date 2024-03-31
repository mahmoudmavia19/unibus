import 'package:unibus/core/app_export.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/data/models/rate.dart';
import 'package:unibus/data/remote_data_source/remote_data_source.dart';
import 'package:unibus/presentation/comapny/drivers_management/model/driver.dart';

class HistoryController extends GetxController {
  Rx<FlowState> flowState = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
  RemoteDataSource remoteDataSource = Get.find<RemoteDataSourceImpl>();

  RxList<Driver> drivers = RxList<Driver>([]);

  getDriverHistory()async{
    flowState.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.getDriversOfRequests()).fold((l) {
      flowState.value = ErrorState(
        StateRendererType.fullScreenErrorState,
        l.message
      ) ;
    }, (r){
      drivers.value = r;
      flowState.value = ContentState();
    });
  }

  addRate(Driver driver)async{
    flowState.value = LoadingState(stateRendererType: StateRendererType.popupLoadingState);
    (await remoteDataSource.addRate(driver)).fold((l) {
      flowState.value = ErrorState(
        StateRendererType.popupErrorState,
        l.message
      ) ;
    }, (r)async{
      await getDriverHistory();
      flowState.value = SuccessState(StateRendererType.popupSuccessState, 'Successfully Rated');
    });
  }

  @override
  void onInit() {
    getDriverHistory();
    super.onInit();
  }
}