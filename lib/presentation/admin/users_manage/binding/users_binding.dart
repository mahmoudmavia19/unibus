import 'package:get/get.dart';
import 'package:unibus/presentation/admin/users_manage/controller/users_controller.dart';

class UsersBinding extends Bindings  {
  @override
  void dependencies() {
    Get.lazyPut(() => UsersController());
  }
}