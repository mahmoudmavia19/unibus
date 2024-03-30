import 'package:flutter/cupertino.dart';
import 'package:unibus/core/app_export.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer.dart';
import 'package:unibus/data/remote_data_source/remote_data_source.dart';
import 'package:unibus/presentation/comapny/price_management/model/price.dart';
import 'package:unibus/presentation/comapny/travels_management/model/trip.dart';
import 'package:unibus/presentation/user/payment_screen/request/request.dart';

import '../../../../core/utils/state_renderer/state_renderer_impl.dart';

class PaymentController extends GetxController {
  Rx<FlowState> state = Rx<FlowState>(ContentState());
  RemoteDataSource remoteDataSource = Get.find<RemoteDateSourceImpl>();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController methodController = TextEditingController();
   var formKey = GlobalKey<FormState>();
   Trip trip  = Get.arguments[0];
   Price price = Get.arguments[1];
   subscribeToTrip()async{
    if(formKey.currentState!.validate()){
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.subscribeToTrip(Request(
      companyId:trip.companyId,
      status: 0,
      date: DateTime.now(),
      tripID: trip.id,
      payment: Payment(
        amount: price.price,
        cardNumber: cardNumberController.text,
        expiryDate: expiryDateController.text,
        cvv: cvvController.text,
        method: methodController.text
      )
    ))).fold((l) {
      state.value = ErrorState(
        StateRendererType.fullScreenErrorState,
        l.message
      ) ;
    }, (r){
      state.value = SuccessState(StateRendererType.fullScreenSuccessState,'Success subscribing to trip');
    });
  }
  }
}