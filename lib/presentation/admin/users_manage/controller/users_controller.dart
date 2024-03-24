import 'package:get/get.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/data/remote_data_source/admin_remote_data_source.dart';
import 'package:unibus/presentation/admin/users_manage/model/user_model.dart';

class UsersController extends GetxController {
  Rx<FlowState> state = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
  AdminRemoteDataSource  remoteDataSource = Get.find<AdminRemoteDataSourceImpl>() ;
  List<UserModel> users = [];

  getUsers()async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.getUsers()).fold((failure) {
      state.value = ErrorState(StateRendererType.fullScreenErrorState, failure.message);
    }, (data) {
      users = data;
      state.value = ContentState();
    }) ;
  }

  blockUser(String userId,int index)async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.blockUser(userId)).fold((failure) {
      state.value = ErrorState(StateRendererType.fullScreenErrorState, failure.message);
    }, (data) async{
      users[index].blocked = !users[index].blocked;
      if(users[index].blocked){
        (await remoteDataSource.blockUser(userId)).fold((failure) {
          state.value = ErrorState(StateRendererType.fullScreenErrorState, failure.message);
        }, (data) {
          state.value = ContentState();
        });
      } else {
        (await remoteDataSource.unblockUser(userId)).fold((failure) {
          state.value = ErrorState(StateRendererType.fullScreenErrorState, failure.message);
        }, (data) {
          state.value = ContentState();
        });
      }
      state.value = ContentState();
    });
  }
  @override
  void onInit() {
    getUsers();
    super.onInit();
  }
}