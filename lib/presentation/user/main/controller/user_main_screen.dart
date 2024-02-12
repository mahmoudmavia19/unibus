import 'package:flutter/cupertino.dart';
import 'package:unibus/core/app_export.dart';

class UserMainController extends GetxController {

  RxInt selectedIndex = 0.obs;
  PageController pageController = PageController();
  void changeIndex(int index){
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }
}