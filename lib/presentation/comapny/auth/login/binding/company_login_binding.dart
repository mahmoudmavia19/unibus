import '../../../../../core/app_export.dart';
import '../controller/company_controller.dart';

class CompanyLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CompanyLoginController());
  }
}