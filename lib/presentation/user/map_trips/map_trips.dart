import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:unibus/core/app_export.dart';
import 'package:unibus/core/constants/constant.dart';
import 'package:unibus/core/utils/app_strings.dart';
import 'package:unibus/presentation/user/map_trips/controller/map_trip_controller.dart';
import 'package:unibus/widgets/drawer/comapnyDrawer.dart';

class MapTripScreen extends GetWidget<MapTripController> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.liveTrip),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            controller.startUpdatingLocations();
          }, icon: Icon(Icons.start)),
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
    );
  }
}
