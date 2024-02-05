import 'package:unibus/presentation/comapny/travels_management/controller/edit_trip_controller.dart';

import '../../../../core/app_export.dart';
 import '../controller/add_trip_controller.dart';
import '../controller/travels_controller.dart';

class TripsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TripController());
    Get.lazyPut(() => AddTripController());
    Get.lazyPut(() => EditTripController());
  }
}