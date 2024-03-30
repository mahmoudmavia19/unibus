import 'package:unibus/core/app_export.dart';
import 'package:unibus/presentation/user/payment_screen/controller/payment_controller.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentController());
  }
}