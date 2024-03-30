import 'package:unibus/core/utils/state_renderer/state_renderer.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/data/remote_data_source/company_remote_data_source.dart';
 import 'package:unibus/presentation/admin/users_manage/model/user_model.dart';
import 'package:unibus/presentation/user/payment_screen/request/request.dart';

import '../../../../core/app_export.dart';

class StudentRequestsController extends GetxController {
  Rx<FlowState> state = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
  CompanyRemoteDataSource remoteDataSource = Get.find<CompanyRemoteDataSourceImpl>();
  RxList<Request> requests = <Request>[].obs;
  RxList<UserModel> users = <UserModel>[].obs;
  getRequests()async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.getRequests()).fold((failure) {
      state.value = ErrorState(StateRendererType.fullScreenErrorState, failure.message);
    }, (r)async{
      for(var item in r){
        (await remoteDataSource.getUser(item.userId!)).fold((failure) {},(user) {
          item.user = user;
        },);
      }
      requests.value = r;
      state.value = ContentState();
    });
  }

  updateRequest(Request request)async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.updateRequest(request)).fold((failure) {
      state.value = ErrorState(StateRendererType.fullScreenErrorState, failure.message);
    }, (r)async{
      await getRequests();
    });
  }
  @override
  void onInit() {
    getRequests();
    super.onInit();
  }

}