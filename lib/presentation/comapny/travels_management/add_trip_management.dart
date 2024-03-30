import 'package:day_picker/day_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:unibus/core/utils/app_strings.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/presentation/comapny/drivers_management/model/driver.dart';

import '../../../core/app_export.dart';
import '../../../core/constants/constant.dart';
import 'controller/add_trip_controller.dart';

class AddTripScreen extends GetWidget<AddTripController> {

  List<DayInWeek> _days = [
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
        isSelected: true,
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          CustomImageView(
            imagePath: ImageConstant.imgLogo,
          ),
        ],
        title: Text(AppStrings.addTrip),
      ),
      body: Obx(() => controller.getState.getScreenWidget(_widget(context), () {}),
      ),
    );
  }

  Widget _widget(context) => SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Form(
      key: controller.flowKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(AppStrings.tripNumber, style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 16.0),
          TextFieldWidget(labelText: AppStrings.tripNumber, controller: controller.tripNumberController),
          SizedBox(height: 16.0),
          Text(AppStrings.day, style: Theme.of(context).textTheme.titleLarge,),
          SizedBox(height: 16.0),
      SelectWeekDays(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        days: _days,
        border: false,
        boxDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
        color: theme.primaryColor
        ),
        onSelect: (values) { // <== Callback to handle the selected days
          print(values);
          controller.trip.days = values;
        },
      ),
          SizedBox(height: 16.0),
          Text(AppStrings.time, style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 16.0),
          TextFieldWidget(labelText: AppStrings.time,
              onTap: () {
                showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) {
                  controller.tripDateTimeController.text = value!.format(context);
                  controller.trip.time = DateTime.tryParse(value.format(context));
                });
              },
              controller: controller.tripDateTimeController),
          SizedBox(height: 16.0),
          Text(AppStrings.driver, style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 16.0),
          SizedBox(height: 16.0),
          DropdownButtonFormField<Driver?>(items: controller.tripController.drivers.map((e) => DropdownMenuItem(
            value: e,
            child: Text(e.name??''),
          )) .toList(),
              value: controller.selectedDriver,
              validator:(value) {
                if(value == null){
                  return 'Please select a driver';
                }
                return null;
              },
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: AppStrings.driver,
                border: OutlineInputBorder(),
              ),
              onChanged:(value) {
                controller.selectedDriver = value;
              }),
          SizedBox(height: 16.0),
          Text(AppStrings.tripEntryGate, style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 16.0),
          TextFieldWidget(labelText: AppStrings.tripEntryGate, controller: controller.tripEnterGateController,
            /*onTap: () {
            _openMapSheet( controller.tripEnterGateController,onTap: (p0) {
              controller.trip.startLocation = p0;
            });
          },*/),

          SizedBox(height: 16.0),
          Text(AppStrings.tripExitGate, style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 16.0),
          TextFieldWidget(labelText: AppStrings.tripExitGate,
            controller: controller.tripExitGateController,
         /* onTap: () {
            _openMapSheet( controller.tripExitGateController,onTap: (p0) {
              controller.trip.endLocation = p0;
            },);
          },*/),

          SizedBox(height: 16.0),
          SizedBox(
            height: 50.0,
            child: ElevatedButton(
              onPressed: (){
                controller.addTrip() ;
              },
              child: Text(AppStrings.addTrip),
            ),
          ),
        ],
      ),
    ),
  );

  _openMapSheet(TextEditingController textController,{void Function(LatLng)? onTap}) {
     Get.bottomSheet( Obx(() {
       return Container(
         child: Stack(
           children: [
             GoogleMap(
               gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                 new Factory<OneSequenceGestureRecognizer>(() => new EagerGestureRecognizer()),
               ].toSet(),
               mapType: MapType.terrain,
               myLocationEnabled: true,
               initialCameraPosition: CameraPosition(
                 target: LatLng(controller.currentLocation_.value.latitude ?? startMapLocation.latitude,
                     controller.currentLocation_.value.longitude ?? startMapLocation.longitude),
                 zoom: 16,
               ),
               onMapCreated: (_controller) {
                 controller.mapController = _controller;
               },
               onTap: (argument) {
                 print(argument);
                 controller.chooseLocation(argument,textController);
                 onTap?.call(argument);
               },
               markers: {
                 Marker(
                   markerId: MarkerId('currentLocation'),
                   position: LatLng(controller.currentLocation_.value.latitude ?? startMapLocation.latitude,
                       controller.currentLocation_.value.longitude ?? startMapLocation.longitude),
                   infoWindow: InfoWindow(title: AppStrings.currentLocation),
                 ),
               },
             ),
             Padding(
               padding: const EdgeInsets.all(20.0),
               child: ElevatedButton(onPressed: () {
                 Get.back();
               },child:Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: (Text('Done')),
               )),
             ),
           ],
         ),
       );
     }),);
  }
}

class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  bool readOnly = false;
  void Function()? onTap ;
    TextFieldWidget({
    Key? key,
    required this.labelText,
    required this.controller,
    this.readOnly = false,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      readOnly: readOnly,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
