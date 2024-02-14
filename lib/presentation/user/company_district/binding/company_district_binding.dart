import '../../../../core/app_export.dart';
import '../controller/company_district_controller.dart';

class CompanyDistrictBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CompanyDistrictController());
  }
}