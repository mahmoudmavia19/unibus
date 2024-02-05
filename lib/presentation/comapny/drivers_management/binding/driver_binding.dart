import '../../../../core/app_export.dart';
import '../controller/drivers_controller.dart';

class DriversBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DriverController());
  }
}