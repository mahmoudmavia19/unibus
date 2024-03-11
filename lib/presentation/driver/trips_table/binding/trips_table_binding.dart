import '../../../../core/app_export.dart';
import '../controller/trips_table_controller.dart';

class TripsTableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TripsTableController());
  }
}