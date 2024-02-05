import '../../../../core/app_export.dart';
import '../controller/profile_controller.dart';

class CompanyProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CompanyController());
  }
}