import 'package:unibus/core/app_export.dart';

import '../controller/driver_rate_controller.dart';

class DriverRateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DriverRateController());
  }
}