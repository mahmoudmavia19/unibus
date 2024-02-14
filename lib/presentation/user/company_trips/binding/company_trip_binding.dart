import '../../../../core/app_export.dart';
import '../controller/company_trips_controller.dart';

class CompanyTripsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CompanyTripsController());
  }
}