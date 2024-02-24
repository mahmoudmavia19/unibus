import '../../../../../core/app_export.dart';
import '../controller/company_register_controller.dart';

class CompanyRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CompanyRegisterController());
  }
}