import '../../../../../core/app_export.dart';
import '../controller/user_register_controller.dart';

class UserRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UseRegisterController());
  }
}