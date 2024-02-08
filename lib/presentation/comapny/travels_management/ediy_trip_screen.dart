import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:unibus/core/utils/app_strings.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/presentation/comapny/travels_management/controller/edit_trip_controller.dart';

import '../../../core/app_export.dart';
import '../../../core/constants/constant.dart';
import 'controller/add_trip_controller.dart';

class EditTripScreen extends GetWidget<EditTripController> {
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
        title: Text(AppStrings.editTrip),
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
          TextFieldWidget(labelText: AppStrings.day, controller: controller.tripDateTimeController,readOnly: true,
              onTap: (){
                showDatePicker(context: context, firstDate:DateTime.now(),
                    lastDate:DateTime.parse('2025-01-01')).then((value) {
                  controller.tripDateTimeController.text = DateFormat.yMMMd().format(value!);
                  controller.trip.time = value;
                });
              }),
          SizedBox(height: 16.0),
          Text(AppStrings.driver, style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 16.0),
          SizedBox(height: 16.0),
          DropdownButtonFormField<String?>(items: controller.drivers.map((e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          )) .toList(),
              value: controller.trip.driver,
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
                controller.trip.driver = value;
              }),
          SizedBox(height: 16.0),
          Text(AppStrings.tripExitGate, style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 16.0),
          TextFieldWidget(labelText: AppStrings.tripExitGate, controller: controller.tripExitGateController,
            onTap: () {
              _openMapSheet( controller.tripExitGateController,onTap: (p0) {
                controller.trip.endLocation = p0;
              },);
            },),
          SizedBox(height: 16.0),
          Text(AppStrings.tripEntryGate, style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 16.0),
          TextFieldWidget(labelText: AppStrings.tripEntryGate, controller: controller.tripEnterGateController,onTap: () {
            _openMapSheet( controller.tripEnterGateController,onTap: (p0) {
              controller.trip.startLocation = p0;
            });
          },),
          SizedBox(height: 16.0),

          SizedBox(height: 16.0),
          SizedBox(
            height: 50.0,
            child: ElevatedButton(
              onPressed: (){
                controller.editTrip() ;
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
