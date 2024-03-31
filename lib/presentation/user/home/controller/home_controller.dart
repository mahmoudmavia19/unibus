import 'package:unibus/core/app_export.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/data/remote_data_source/remote_data_source.dart';
import 'package:unibus/presentation/admin/companies_management/model/company_model.dart';

class HomeController extends GetxController {
  RxList<Company> companies = RxList<Company>([]);
  Rx<FlowState> state = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
  RemoteDataSource remoteDataSource = Get.find<RemoteDataSourceImpl>();

  Future<void> getCompanies() async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.getCompany()).fold((l) {
      state.value = ErrorState(StateRendererType.fullScreenErrorState,l.message);
    }, (r){
      companies.value = r;
      state.value = ContentState();
    });
  }

  @override
  void onInit() async{
    await getCompanies() ;
    super.onInit();
  }
}