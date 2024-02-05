
import 'package:unibus/core/utils/state_renderer/state_renderer.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/presentation/comapny/price_management/model/price.dart';

import '../../../../core/app_export.dart';

class PriceController extends GetxController {
  final districtPrices = <Price>[].obs;
  Rx<FlowState> state = Rx<FlowState>(EmptyState('')); 
  void addPrice(Price price) {
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);

    districtPrices.add(price);
    state.value = SuccessState(StateRendererType.popupSuccessState, '');
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
    super.onInit();
  }

    void editPrice(int index, Price price) {
      try {
        state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
        districtPrices[index] = price;
        checkState()  ;
      } catch (e) {
        state.value = ErrorState(StateRendererType.popupErrorState, 'Error updating price: $e');
      }
    }


  void deletePrice(int index) { 
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    districtPrices.removeAt(index);
    checkState()  ;
  }
}