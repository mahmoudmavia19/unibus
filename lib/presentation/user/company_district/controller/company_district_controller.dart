import 'package:flutter/material.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/data/remote_data_source/remote_data_source.dart';
import 'package:unibus/presentation/admin/companies_management/model/company_model.dart';
import 'package:unibus/presentation/comapny/price_management/model/price.dart';

import '../../../../core/app_export.dart';

class CompanyDistrictController extends GetxController {

  Rx<FlowState> state = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
  RemoteDataSource remoteDataSource = Get.find<RemoteDateSourceImpl>() ;
  var formKey = GlobalKey<FormState>();
  RxList<Price> prices = RxList<Price>([]);
  Company company = Get.arguments;
  getPrices() async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.getPrices(company.companyId!)).fold((l) {
      state.value = ErrorState(
        StateRendererType.fullScreenErrorState,
        l.message
      ) ;
    }, (r){
      prices.value = r;
      state.value = ContentState();
    });
  }

  @override
  void onInit() {
    getPrices();
    super.onInit();
  }
}