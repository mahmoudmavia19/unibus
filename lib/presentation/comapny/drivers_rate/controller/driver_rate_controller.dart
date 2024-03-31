import 'package:unibus/core/app_export.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
 import 'package:unibus/data/remote_data_source/company_remote_data_source.dart';
import 'package:unibus/presentation/comapny/drivers_management/controller/drivers_controller.dart';

class DriverRateController extends GetxController {
  Rx<FlowState> state = Rx<FlowState>(ContentState());
  CompanyRemoteDataSource remoteDataSource = Get.find<CompanyRemoteDataSourceImpl>();
 DriverController driverController = Get.find();

  @override
  void onInit() {
    super.onInit();
  }

}