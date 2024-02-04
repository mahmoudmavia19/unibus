import '../../../../core/app_export.dart';
import '../controller/admin_porfile_controller.dart';

class AdminProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminProfileController());
  }
}