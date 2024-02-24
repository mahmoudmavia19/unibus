import '../../../../core/app_export.dart';
import '../controller/home_controller.dart';

class DriverHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DriverHomeController());
  }
}