import 'package:unibus/core/app_export.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/data/models/notification.dart';
import 'package:unibus/data/remote_data_source/remote_data_source.dart';

class NotificationController extends GetxController {
  RxList<Notification> notifications = <Notification>[].obs;
  Rx<FlowState> state = Rx<FlowState>(ContentState());

  RemoteDataSource remoteDataSource = Get.find<RemoteDataSourceImpl>();

  getNotifications() async{
    var response = await remoteDataSource.getNotifications();
    response.listen((event) {
      notifications.value = event;
      if(notifications.isEmpty){
        state.value = EmptyState('Notifications are empty');
      }else{
        state.value = ContentState();
      }
    });
  }

  @override
  void onInit() {
    getNotifications();
    super.onInit();
  }


}