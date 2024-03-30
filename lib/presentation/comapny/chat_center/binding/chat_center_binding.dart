import 'package:unibus/presentation/comapny/chat_center/controller/chat_room_controller.dart';

import '../../../../core/app_export.dart';
import '../controller/chat_center_controller.dart';

class ChatCenterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatCenterController());
    Get.lazyPut(() => CompanyChatRoomController());
  }
}