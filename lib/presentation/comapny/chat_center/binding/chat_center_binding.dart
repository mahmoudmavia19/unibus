import '../../../../core/app_export.dart';
import '../controller/chat_center_controller.dart';

class ChatCenterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatCenterController());
  }
}