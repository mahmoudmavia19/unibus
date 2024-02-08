import '../../../../core/app_export.dart';
import '../controller/live_trip_controller.dart';

class LiveTripBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LiveTripController());
  }
}