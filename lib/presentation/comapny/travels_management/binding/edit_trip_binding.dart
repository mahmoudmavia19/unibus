import '../../../../core/app_export.dart';
import '../controller/edit_trip_controller.dart';

class EditTripBinding  extends  Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditTripController());
  }
}