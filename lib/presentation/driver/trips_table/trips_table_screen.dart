import 'package:day_picker/day_picker.dart';
import 'package:day_picker/model/day_in_week.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unibus/core/app_export.dart';

class TripsTableScreen extends StatelessWidget {
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
              print(values);
             },
          ),
          SizedBox(height: 16.0),
           Expanded(
            child: ListView.builder(
             itemBuilder: (context, index) => _itemBuilder(context, index),
             itemCount: 4,
            ),
          ),
        ],
      ),
    );
  }
  _itemBuilder(context, index) {
    return  Column(
      children: [
        ListTile(
          leading: Icon(Icons.bus_alert_outlined,color: theme.primaryColor,),
          title: Text('Trip ${index+1}',style: TextStyle(fontWeight: FontWeight.bold),),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('enter gate : 12'),
              Text('exit gate : 23'),
              Text('time :${DateFormat.jm().format(DateTime.now().add(Duration(hours: index)))}'),
            ],
          ),
          trailing:ElevatedButton(onPressed: () {
            Get.toNamed(AppRoutes.driverHomeScreen) ;
          },
            child: Text('Go'),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
              backgroundColor: MaterialStateProperty.all(index==0?Colors.green:Colors.grey),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ))
            ) ,),
        ),
        Divider()
      ],
    );
  }
}
