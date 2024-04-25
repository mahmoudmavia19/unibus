
import 'package:day_picker/model/day_in_week.dart';
import 'package:flutter/material.dart';
import 'package:unibus/presentation/comapny/drivers_management/model/driver.dart';
import 'package:unibus/presentation/comapny/travels_management/controller/travels_controller.dart';
import 'package:unibus/presentation/comapny/travels_management/model/trip.dart';
import '../../../../core/app_export.dart';
import '../../../../core/utils/state_renderer/state_renderer_impl.dart';

import '../../price_management/model/price.dart';
class EditTripController extends GetxController {
  int index = Get.arguments[0] ;
  Trip trip = Get.arguments[1] ;
 late final  tripTitleController;
 late final  tripNumberController;
 late final  tripDateTimeController;
 late final  tripExitGateController;
 late final  tripEnterGateController;
 late final  tripContentController;
  List<DayInWeek> days = [
    DayInWeek(
      "Sat",
      dayKey: "Sat",
    ),
    DayInWeek(
      "Sun",
      dayKey: "Sun",

    ),
    DayInWeek(
      "Mon",
      dayKey: "Mon",
    ),
    DayInWeek(
      "Tue",
      dayKey: "Tue",
    ),
    DayInWeek(
      "Wed",
      dayKey: "Wed",
    ),
    DayInWeek(
      "Thu",
      dayKey: "Thu",
    ),
  ];

  final GlobalKey<FormState> flowKey = GlobalKey<FormState>();
  Rx<FlowState> state = Rx<FlowState>(ContentState());
  TripController tripController = Get.put(TripController());
  Rx<Driver?> selectedDriver = Rx<Driver?>(null);
  Rx<Price?> selectedDistrict = Rx<Price?>(null);
   FlowState get getState => state.value;

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() async{
    tripNumberController = TextEditingController(text: trip.number);
    tripDateTimeController = TextEditingController(text: trip.time?.format());
     tripExitGateController = TextEditingController(text: trip.exitGate);
    tripEnterGateController = TextEditingController(text: trip.enterGate);
    for(var i=0 ; i<days.length;i++){
       days[i].isSelected = trip.days?.contains(days[i].dayKey)??false;
    }
    selectedDriver.value = tripController.drivers.where((p0) => p0.uid == trip.driver).first;
    selectedDistrict.value = tripController.districts.where((p0) => p0.uid == trip.district).first;
    if(tripController.drivers.isEmpty){
      await tripController.getDrivers();
      selectedDriver.value = tripController.drivers.where((p0) => p0.uid == trip.driver).first;
    }

    if(tripController.drivers.isEmpty){
      await tripController.getDistricts();
      selectedDistrict.value = tripController.districts.where((p0) => p0.uid == trip.district).first;
    }
     super.onInit();
  }

  Future<void> editTrip() async {
    if (flowKey.currentState!.validate()) {
      trip.enterGate = tripEnterGateController.text;
      trip.exitGate = tripExitGateController.text;
      trip.driver = selectedDriver.value?.uid??'';
      trip.district = selectedDistrict.value?.uid??'';
      trip.number = tripNumberController.text;
      tripController.editTrip(index,trip);
      Get.back();
    }
  }
}