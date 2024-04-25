import 'package:day_picker/day_picker.dart';
  import 'package:flutter/material.dart';

import 'package:unibus/core/utils/app_strings.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/presentation/comapny/drivers_management/model/driver.dart';
import 'package:unibus/presentation/comapny/travels_management/controller/edit_trip_controller.dart';

import '../../../core/app_export.dart';
import '../price_management/model/price.dart';
import 'model/trip.dart';


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
          SelectWeekDays(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            days: controller.days,
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
                  controller.trip.time=TimeOfDayData(value.hour,value.minute);
                });
              },
              controller: controller.tripDateTimeController),
          SizedBox(height: 16.0),
          Text(AppStrings.driver, style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 16.0),
          SizedBox(height: 16.0),
          Obx(
            ()=> DropdownButtonFormField<Driver?>(items: controller.tripController.drivers.map((e) => DropdownMenuItem(
              value: e,
              child: Text(e.name??''),
            )) .toList(),
                value: controller.selectedDriver.value,
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
                  controller.selectedDriver.value = value;
                }),
          ),
          SizedBox(height: 16.0),
          Text(AppStrings.district, style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 16.0),
          Obx(
                ()=> DropdownButtonFormField<Price?>(items: controller.tripController.districts.map((e) => DropdownMenuItem(
              value: e,
              child: Text(e.district??''),
            )) .toList(),
                value: controller.selectedDistrict.value,
                validator:(value) {
                  if(value == null){
                    return 'Please select a district';
                  }
                  return null;
                },
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: AppStrings.district,
                  border: OutlineInputBorder(),
                ),
                onChanged:(value) {
                  controller.selectedDistrict.value = value;
                }),
          ),
          SizedBox(height: 16.0),
          Text(AppStrings.tripExitGate, style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 16.0),
          TextFieldWidget(labelText: AppStrings.tripExitGate, controller: controller.tripExitGateController,),
          SizedBox(height: 16.0),
          Text(AppStrings.tripEntryGate, style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 16.0),
          TextFieldWidget(labelText: AppStrings.tripEntryGate, controller: controller.tripEnterGateController,),
          SizedBox(height: 16.0),
          SizedBox(
            height: 50.0,
            child: ElevatedButton(
              onPressed: (){
                controller.editTrip() ;
              },
              child: Text(AppStrings.editTrip),
            ),
          ),
        ],
      ),
    ),
  );
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
