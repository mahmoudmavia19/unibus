import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibus/core/utils/app_strings.dart';
import 'package:unibus/presentation/user/home/home_screen.dart';
import 'package:unibus/presentation/user/main/controller/user_main_screen.dart';
import 'package:unibus/presentation/user/map_trips/map_trips.dart';

import '../../../core/utils/image_constant.dart';

class MainScreen extends GetWidget<UserMainController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appName),
        actions: [
          Image.asset(ImageConstant.imgLogo),
        ]
      ),
      body:PageView(
        controller: controller.pageController,
        children: [
         HomeScreen(),
          MapTripScreen(),
          Center(child: Text('Notifications')),
          Center(child: Text('Profile')),
        ],
        onPageChanged: (value) {
          controller.changeIndex(value);
        },
      ),
      bottomNavigationBar: Obx(()=>BottomNavigationBar(
            items:[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'Map'),
              BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            ],
            currentIndex: controller.selectedIndex.value,
            onTap: (index){
              controller.changeIndex(index);
            },
            type: BottomNavigationBarType.fixed
        ),
      ),
    );
  }
}
