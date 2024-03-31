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
      body:GoogleMap(
          mapType: MapType.terrain,
          myLocationEnabled: true,
          circles: {
            Circle(
              circleId: const CircleId("start"),
              center: LatLng(
                testPath.first.latitude,
                testPath.first.longitude,
              ),
              radius: 2,
            )
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(testPath.first.latitude, testPath.first.longitude),
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
                  markerId: MarkerId('2'),
                  position: LatLng(testPath.first.latitude,testPath.first.longitude),
                  infoWindow: InfoWindow(title:'2'),
                ),
            Marker(
              markerId: MarkerId('1'),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
              position: LatLng(testPath.last.latitude,testPath.last.longitude),
              infoWindow: InfoWindow(title:'1'),
            ),
          },
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
                      controller.stopUpdatingLocations();
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
