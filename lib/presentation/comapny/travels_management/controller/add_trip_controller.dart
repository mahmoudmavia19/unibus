import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:unibus/presentation/comapny/travels_management/controller/travels_controller.dart';
import 'package:unibus/presentation/comapny/travels_management/model/trip.dart';

import '../../../../core/app_export.dart';
import '../../../../core/utils/state_renderer/state_renderer.dart';
import '../../../../core/utils/state_renderer/state_renderer_impl.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
class AddTripController extends GetxController {
  final tripTitleController = TextEditingController();
  final tripNumberController = TextEditingController();
  final tripDateTimeController = TextEditingController();
  final tripExitGateController = TextEditingController();
  final tripEnterGateController = TextEditingController();
   final tripContentController = TextEditingController();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final Rx<LocationData> currentLocation_ = Rx(LocationData.fromMap({}));
  late GoogleMapController mapController;
  final GlobalKey<FormState> flowKey = GlobalKey<FormState>();
  Rx<FlowState> state = Rx<FlowState>(ContentState());
  TripController tripController = Get.put(TripController());
  Trip trip = Trip();
  FlowState get getState => state.value;

  @override
  void onClose() {
    mapController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    _getCurrentLocation();
    super.onInit();
  }

  chooseLocation(LatLng target,TextEditingController controller) async{
    currentLocation_.value = LocationData.fromMap({
      'latitude': target.latitude,
      'longitude': target.longitude,
    });
    controller.text = await getAddressFromCoordinates(LatLng(currentLocation_.value.latitude!, currentLocation_.value.longitude!));
  }

  Future<void> _getCurrentLocation() async {
    Location location = Location();
    LocationData currentLocation = await location.getLocation();
    currentLocation_.value = currentLocation;
  }

  Future<String> getAddressFromCoordinates(LatLng latlng) async {
    try {
      List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(latlng.latitude, latlng.longitude);

      if (placemarks.isNotEmpty) {
        geocoding.Placemark placemark = placemarks[0];
        print("${placemark.street}, ${placemark.locality}, ${placemark.country}");
        return "${placemark.street}, ${placemark.locality}, ${placemark.country}";
        // Set the address to the controller or use it as needed
      } else {
        print('No address found');
        return "";
      }
    } catch (e) {
      print("Error: $e");
      print('Error getting address');
      return "";
    }
  }


  Future<void> addTrip() async {
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    if (flowKey.currentState!.validate()) {
      trip.enterGate = tripEnterGateController.text;
      trip.exitGate = tripExitGateController.text;
       trip.driver = tripNumberController.text;
       trip.number = tripNumberController.text;
       tripController.addTrip(trip);
      Get.back();
    }

  }
}