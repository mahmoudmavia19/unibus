import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unibus/core/app_export.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/presentation/comapny/travels_management/model/trip.dart';
import 'package:unibus/presentation/driver/trips_table/controller/trips_table_controller.dart';

class TripsTableScreen extends GetWidget<TripsTableController> {
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
        leading: Container(),
        title: Text('Trips Schedule Screen'),
        actions: [
          Image.asset(ImageConstant.imgLogo)
        ],
      ),
      body: Column(
        children: [
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
              controller.days = values;
              controller.filterTrips();
            },
          ),
          SizedBox(height: 16.0),
          Expanded(
              child: Obx(() =>
                  controller.state.value
                      .getScreenWidget(_body(), () {
                    controller.getTrips();
                  }),)
          ),
        ],
      ),
    );
  }

  _body() =>
      ListView.builder(
        itemBuilder: (context, index) =>
            _itemBuilder(context, controller.trips[index]),
        itemCount: controller.filteredTrips.length,
      );

  _itemBuilder(context, Trip trip) {
    {
      bool isStarted = DateFormat.jm().format(
          trip.time ?? DateTime.now()) == DateFormat.jm().format(
          DateTime.now()
          );
      return Column(
        children: [
          ListTile(
            leading: Icon(Icons.bus_alert_outlined, color: theme.primaryColor,),
            title: Text(trip.number ?? '',
              style: TextStyle(fontWeight: FontWeight.bold,color: theme.primaryColor),),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('enter gate : ${trip.enterGate ?? ''}'),
                Text('exit gate : ${trip.exitGate ?? ''}'),
                Text('time :${DateFormat.jm().format(
                    trip.time ?? DateTime.now())}'),
              ],
            ),
            trailing: ElevatedButton(onPressed: () {
              if(isStarted) {
                Get.toNamed(AppRoutes.driverHomeScreen);
              } else {
                Get.defaultDialog(
                  title: 'Alert',
                  middleText: 'You have not started your trip yet',
                );
              }
            },
              child: Text('Go'),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
                  backgroundColor: MaterialStateProperty.all(!isStarted?Colors.grey:Colors.green),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ))
              ),),
          ),
          Divider()
        ],
      );
    }
  }
}
