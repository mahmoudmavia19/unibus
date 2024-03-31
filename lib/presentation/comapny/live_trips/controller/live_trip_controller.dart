import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:unibus/core/constants/constant.dart';
import 'package:get/get.dart';
import 'dart:math';

class LiveTripController extends GetxController {
  final Rx<LocationData> startLocation = Rx(LocationData.fromMap({
    'latitude': testPath.first.latitude,
    'longitude': testPath.first.longitude,
  }));
  final Rx<LocationData> endLocation = Rx(LocationData.fromMap({
    'latitude': testPath.last.latitude,
    'longitude': testPath.last.longitude,
  }));
  late GoogleMapController mapController;

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
}
