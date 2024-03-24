import 'package:get/get.dart';
import 'package:unibus/data/remote_data_source/admin_remote_data_source.dart';
import 'package:unibus/presentation/admin/companies_management/model/company_model.dart';

import '../../../../core/utils/state_renderer/state_renderer.dart';
import '../../../../core/utils/state_renderer/state_renderer_impl.dart';

class CompaniesController extends GetxController {
   Rx<FlowState> state = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
   AdminRemoteDataSource  remoteDataSource = Get.find<AdminRemoteDataSourceImpl>() ;
   List<Company> companies = [];
   getCompanies()async{
     state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
     (await remoteDataSource.getCompany()).fold((failure) {
       state.value = ErrorState(StateRendererType.fullScreenErrorState, failure.message);
     }, (data) {
       companies = data;
       state.value = ContentState();
     });
   }

   blockCompany(Company company)async{
     state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
      company.blocked = !company.blocked;
      if(company.blocked){
        (await remoteDataSource.blockCompany(company.companyId??'')).fold((failure) {
          state.value = ErrorState(StateRendererType.fullScreenErrorState, failure.message);
        }, (data) {
          state.value = ContentState();
        });
      } else {
        (await remoteDataSource.unblockCompany(company.companyId??'')).fold((failure) {
          state.value = ErrorState(StateRendererType.fullScreenErrorState, failure.message);
        }, (data) {
          state.value = ContentState();
        });
      }
   }

   @override
  void onInit() {
    getCompanies();
    super.onInit();
  }
}