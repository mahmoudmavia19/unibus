import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:unibus/core/app_export.dart';
import 'package:unibus/presentation/driver/home/controller/home_controller.dart';

import '../../../core/constants/constant.dart';

class DriverHomeScreen extends GetWidget<DriverHomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text('Trip Screen'),
        actions: [
          Image.asset(ImageConstant.imgLogo)
        ],
      ),
      body: Obx(
            () => GoogleMap(
          gestureRecognizers: {
            Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
            )
          } ,
          mapType: MapType.terrain,
          myLocationEnabled: true,
          circles: {
            Circle(
              circleId: const CircleId("start"),
              center: LatLng(
                startMapLocation.latitude,
                startMapLocation.longitude,
              ),
              radius: 2,
            )
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(startMapLocation.latitude, startMapLocation.longitude),
            zoom: 19,
          ),
          onMapCreated: (_controller) {
            controller.mapController = _controller;
          },
          polylines: {
            Polyline(
              polylineId: const PolylineId("route"),
              points: controller.polylineCoordinates,
              color: theme.primaryColor,
              width: 6,
            ),
          },
          onTap: (argument) {
            print(argument);
          },
          markers: {
            Marker(
              markerId: MarkerId('Start Location'),
              position: LatLng(controller.startLocation.value.latitude ?? startMapLocation.latitude,
                  controller.startLocation.value.longitude ?? startMapLocation.longitude),
              infoWindow: InfoWindow(title: 'Start Location'),
            ),
            Marker(
              markerId: MarkerId('End Location'),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
              position: LatLng(controller.endLocation.value.latitude ?? startMapLocation.latitude,
                  controller.endLocation.value.longitude ?? startMapLocation.longitude),
              infoWindow: InfoWindow(title: 'End Location'),
            ),
          },
        ),
      ),
      bottomSheet: Container(
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: Container(
                 child: TextButton(
                  onPressed: () {
                    controller.startUpdatingLocations();
                  },
                  child: Text('Start Trip',style: TextStyle(fontSize: 16.0),),
                ),
              )
            ),
            Expanded(
                child: Container(
                  child: TextButton(
                    onPressed: () {

                    },
                    child: Text('End Trip',style: TextStyle(fontSize: 16.0),),
                  ),
                )
            ),
            Expanded(
                child: Container(
                  child: TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Logout',style: TextStyle(color: Colors.red,fontSize: 16.0),),
                  ),
                )
            ),
          ]
        )  ,
      ),
    );
  }
}
