import '../../../../core/app_export.dart';
import '../controller/add_trip_controller.dart';
import '../controller/edit_trip_controller.dart';

class AddTripBinding  extends  Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddTripController());
  }
}