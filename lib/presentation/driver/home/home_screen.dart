import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:unibus/core/app_export.dart';
import 'package:unibus/presentation/driver/home/controller/home_controller.dart';

class DriverHomeScreen extends GetWidget<DriverHomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text('Home Screen'),
        actions: [
          Image.asset(ImageConstant.imgLogo)
        ],
      ),
      body: GoogleMap (
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194),
          zoom: 14.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){

      },child: Text('Start Trip',textAlign: TextAlign.center),
        elevation: 20.0,

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
