import '../../../../core/app_export.dart';
import '../controller/map_trip_controller.dart';

class MapTripBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MapTripController());
  }
}