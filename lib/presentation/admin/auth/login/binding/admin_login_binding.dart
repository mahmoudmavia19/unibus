import '../../../../../core/app_export.dart';
import '../controller/admin_controller.dart';

class AdminLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminLoginController());
  }
}