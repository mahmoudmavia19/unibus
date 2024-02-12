import 'dart:async';

import 'package:unibus/core/app_export.dart';
import 'package:unibus/presentation/splash_screen/models/splash_model.dart';

/// A controller class for the SplashScreen.
///
/// This class manages the state of the SplashScreen, including the
/// current splashModelObj
class SplashController extends GetxController {
  Rx<SplashModel> splashModelObj = SplashModel().obs;

  @override
  void onInit() {
    Timer(Duration(seconds: 3), () {
      Get.offAllNamed(AppRoutes.switchScreen);
    });
    super.onInit();
  }
}
