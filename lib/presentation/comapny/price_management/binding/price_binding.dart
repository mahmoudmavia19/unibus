import '../../../../core/app_export.dart';
import '../controller/price_controller.dart';

class PriceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PriceController());
  }
}