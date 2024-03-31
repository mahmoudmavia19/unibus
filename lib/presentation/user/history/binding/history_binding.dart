import 'package:unibus/core/app_export.dart';
import 'package:unibus/presentation/user/history/controller/history_controller.dart';

class HistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HistoryController());
  }
}