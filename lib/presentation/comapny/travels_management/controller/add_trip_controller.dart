import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:unibus/data/remote_data_source/company_remote_data_source.dart';
import 'package:unibus/presentation/comapny/price_management/model/price.dart';
import 'package:unibus/presentation/comapny/travels_management/controller/travels_controller.dart';
import 'package:unibus/presentation/comapny/travels_management/model/trip.dart';

import '../../../../core/app_export.dart';
import '../../../../core/utils/state_renderer/state_renderer.dart';
import '../../../../core/utils/state_renderer/state_renderer_impl.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

import '../../drivers_management/model/driver.dart';
class AddTripController extends GetxController {
  final tripTitleController = TextEditingController();
  final tripNumberController = TextEditingController();
  final tripDateTimeController = TextEditingController();
  final tripExitGateController = TextEditingController();
  final tripEnterGateController = TextEditingController();
   final tripContentController = TextEditingController();
  final Rx<File?> selectedImage = Rx<File?>(null);
   final GlobalKey<FormState> flowKey = GlobalKey<FormState>();
  Rx<FlowState> state = Rx<FlowState>(ContentState());
  TripController tripController = Get.put(TripController());
  Trip trip = Trip();
  Driver? selectedDriver ;
  Price? selectedDistrict ;
  FlowState get getState => state.value;
  CompanyRemoteDataSource remoteDataSource = Get.find<CompanyRemoteDataSourceImpl>();


  @override
  void onClose() {
     super.onClose();
  }

  @override
  void onInit()async {
     super.onInit();
  }


  Future<void> addTrip() async {
     if (flowKey.currentState!.validate()) {
      trip.enterGate = tripEnterGateController.text;
      trip.exitGate = tripExitGateController.text;
        trip.number = tripNumberController.text;
        trip.driver = selectedDriver?.uid??'';
        trip.district = selectedDistrict?.uid??'';
       tripController.addTrip(trip);
      Get.back();
    }

  }
}