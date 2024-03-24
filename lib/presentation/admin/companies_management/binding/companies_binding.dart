import 'package:get/get.dart';
import 'package:unibus/presentation/admin/companies_management/controller/companies_controller.dart';

class CompaniesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CompaniesController());
  }
}