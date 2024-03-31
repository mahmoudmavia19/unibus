import 'package:unibus/core/app_export.dart';
import 'package:unibus/presentation/user/notification/controller/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationController());
  }
}