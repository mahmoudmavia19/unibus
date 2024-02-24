import '../../../../../core/app_export.dart';
import '../controller/user_controller.dart';

class UserLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserLoginController());
  }
}