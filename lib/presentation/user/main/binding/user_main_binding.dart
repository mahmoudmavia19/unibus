import 'package:unibus/presentation/user/home/binding/home_binding.dart';
import 'package:unibus/presentation/user/map_trips/controller/map_trip_controller.dart';

import '../../../../core/app_export.dart';
import '../controller/user_main_screen.dart';

class UserMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserMainController());
    Get.lazyPut(() => MapTripController());
    Get.lazyPut(() => HomeBinding());

  }
}