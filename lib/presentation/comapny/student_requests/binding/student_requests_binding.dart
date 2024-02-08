import '../../../../core/app_export.dart';
import '../controller/student_requests_controller.dart';

class StudentRequestsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StudentRequestsController());
  }
}