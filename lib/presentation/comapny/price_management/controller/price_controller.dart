
import 'package:unibus/core/utils/state_renderer/state_renderer.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/data/remote_data_source/company_remote_data_source.dart';
import 'package:unibus/presentation/comapny/price_management/model/price.dart';

import '../../../../core/app_export.dart';

class PriceController extends GetxController {
  final districtPrices = <Price>[].obs;
  Rx<FlowState> state = Rx<FlowState>(EmptyState(''));
  CompanyRemoteDataSource remoteDataSource = Get.find<CompanyRemoteDataSourceImpl>();
  void addPrice(Price price) async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.addPrice(price)).fold((failure) {
      state.value = ErrorState(StateRendererType.popupErrorState,failure.message);
    }, (l) async{
      await getPrices();
      state.value = SuccessState(StateRendererType.popupSuccessState,'Success add price');
    });
  }
   Future<void>getPrices() async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.getPrices()).fold((failure) {
      state.value = ErrorState(StateRendererType.popupErrorState,failure.message);
    }, (l) {
      districtPrices.value = l;
      state.value = ContentState();
    });
  }
  checkState() {
    if(districtPrices.isEmpty) {
      state.value = EmptyState('');
    } else {
      state.value = ContentState();
    }
  }
  @override
  void onInit() {
    getPrices();
    super.onInit();
  }

    void editPrice(Price price) async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.updatePrice(price)).fold((failure) {
      state.value = ErrorState(StateRendererType.popupErrorState,failure.message);
    }, (l) {
      state.value = ContentState();
    });

    }


  void deletePrice(int index) async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.deletePrice(districtPrices[index])).fold((failure) {
      state.value = ErrorState(StateRendererType.popupErrorState,failure.message);
    }, (l) async{
      await getPrices();
      state.value = SuccessState(StateRendererType.popupSuccessState, 'Success delete price');
    });
  }
}