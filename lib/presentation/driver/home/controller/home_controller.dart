import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:unibus/data/remote_data_source/driver_remote_data_source.dart';
import 'package:unibus/presentation/comapny/travels_management/model/trip.dart';

import '../../../../core/app_export.dart';
import '../../../../core/constants/constant.dart';
import '../../../../data/models/notification.dart' as noti;

class DriverHomeController extends GetxController {
  final Rx<LocationData> startLocation = Rx(LocationData.fromMap({
    'latitude': testPath.first.latitude,
    'longitude': testPath.first.longitude,
  }));
  final Rx<LocationData> endLocation = Rx(LocationData.fromMap({
    'latitude': testPath.last.latitude,
    'longitude': testPath.last.longitude,
  }));
  final Rx<LocationData> currentLocation_ = Rx(LocationData.fromMap({}));

  Trip trip = Get.arguments;
  late GoogleMapController mapController;
  DriverRemoteDataSource remoteDataSource = Get.find<DriverRemoteDataSourceImpl>();
  List<LatLng> polylineCoordinates = [];

  @override
  void onInit() {
    getPolyPoints();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void startUpdatingLocations() {
    sendNotification('Trip started');
    sendCurrentTrip();
  getCurrentLocation();
  }
  void stopUpdatingLocations() {
    Get.defaultDialog(
      title: 'Trip Alert',
      middleText: 'Are you sure you want to end the trip?',
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            endCurrentTrip();
            sendNotification('Trip ended');
            Get.back();
            Get.back();
          },
          child: Text('End Trip'),
        )
      ]
    );

  }
  double calculateDistance(LatLng point1, LatLng point2) {
    const double earthRadius = 6371000; // in meters

    // Convert latitude and longitude from degrees to radians
    double lat1Rad = degreesToRadians(point1.latitude);
    double lon1Rad = degreesToRadians(point1.longitude);
    double lat2Rad = degreesToRadians(point2.latitude);
    double lon2Rad = degreesToRadians(point2.longitude);

    // Haversine formula
    double deltaLat = lat2Rad - lat1Rad;
    double deltaLon = lon2Rad - lon1Rad;
    double a = sin(deltaLat / 2) * sin(deltaLat / 2) +
        cos(lat1Rad) * cos(lat2Rad) * sin(deltaLon / 2) * sin(deltaLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    return distance;
  }

  double degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }


  void updateLocations(timer) {
    // Update start location coordinates (move towards end location)
    if (startLocation.value.latitude! < endLocation.value.latitude!) {
      startLocation.value = LocationData.fromMap({
        'latitude': startLocation.value.latitude! + 0.0001,
        'longitude': startLocation.value.longitude! + 0.0001,
      });
      print(calculateDistance(LatLng(startLocation.value.latitude!, startLocation.value.longitude!), LatLng(endLocation.value.latitude!, endLocation.value.longitude!)));
      if(calculateDistance(LatLng(startLocation.value.latitude!, startLocation.value.longitude!), LatLng(endLocation.value.latitude!, endLocation.value.longitude!)) == 113.59036586978884){
        Get. snackbar('Trip Alert', 'Trip very close');
      }
    }   else {
      // Stop the timer when the end point is reached
      Get. snackbar('Trip Alert', 'Trip ended');
      timer.cancel();
    }

    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 16,
          target: LatLng(startLocation.value.latitude!, startLocation.value.longitude!),
        ),
      ),
    );
    update();
  }

  void getPolyPoints() {
    polylineCoordinates= testPath;

   }
   sendNotification(body)async{
    var notification =noti.Notification(
      title: trip.number,
      body: body,
      time: DateTime.now(),
      tripId: trip.id
    );
     (await remoteDataSource.sendNotification(notification)).fold((l) {}, (r) {});
   }

   sendCurrentTrip()async{
     (await remoteDataSource.currentTrip(trip)).fold((l) => null, (r) => null);
   }

   endCurrentTrip()async{
     (await remoteDataSource.deleteCurrentTrip(trip)).fold((l) => null, (r) => null);
   }
  shareLocation(LatLng location)async{
    (await remoteDataSource.shareMyLocation(location)).fold((l) {

    }, (r) {

    });
  }
  Location location = Location();


  void getCurrentLocation() async {
    Get. snackbar('Trip Alert', 'Trip Started');
    location.onLocationChanged.listen(
          (newLoc) { 
        currentLocation_.value = newLoc;
        shareLocation(LatLng(newLoc.latitude!, newLoc.longitude!));
        if (newLoc.latitude! < endLocation.value.latitude!) {

          if(calculateDistance(LatLng(newLoc.latitude!,newLoc.longitude!),
              LatLng(endLocation.value.latitude!,endLocation.value.longitude!))== 20){
            Get. snackbar('Trip Alert', 'Trip very close');
          }
         }   else if(calculateDistance(LatLng(newLoc.latitude!,newLoc.longitude!),
            LatLng(endLocation.value.latitude!,endLocation.value.longitude!))==0) {
          // Stop the timer when the end point is reached
         }

        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 19,
              target: LatLng( currentLocation_.value.latitude!,  currentLocation_.value.longitude!),
            ),
          ),
        );
      },
    );
  }

}