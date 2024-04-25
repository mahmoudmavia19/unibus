import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:unibus/core/app_export.dart';
import 'package:unibus/presentation/comapny/drivers_management/model/driver.dart';

class Trip {
   String? id;
   String? number;
   String? district;
   String? companyId;
   String? enterGate;
   String? exitGate;
   String? driver;
   Driver? driverModel;
    List<String>? days;
   TimeOfDayData? time ;

   Trip({this.number, this.enterGate, this.exitGate,
   this.driver, this.id,this.days , this.time});

   Trip.fromJson(Map<String, dynamic> json) {
     number = json['number'];
     enterGate = json['enterGate'];
     exitGate = json['exitGate'];
     driver = json['driver'];
     id = json['id'];
     district = json['district'];
     days = json['days'].cast<String>();
      if(json['time'] is Timestamp) {
        time = json['time'].toDate();
      } else {
        time = json['time']!=null?TimeOfDayData.fromJson(json['time']):null;
      }
     companyId = json['companyId'];
   }
   toJson() {
     return {
       'number': number,
       'enterGate': enterGate,
       'exitGate': exitGate,
       'driver': driver,
       'id': id,
       'days': days,
       'time': time?.toJson(),
       'companyId': companyId ,
       'district': district
     };
   }
}


class TimeOfDayData {
  final int hour;
  final int minute;

  TimeOfDayData(this.hour, this.minute);

  TimeOfDayData.fromJson(Map<String, dynamic> json)
      : hour = json['hour'],
        minute = json['minute'];
  format(){
    return TimeOfDay(hour: hour, minute: minute).format(Get.context!);
  }


  Map<String, dynamic> toJson() {
    return {
      'hour': hour,
      'minute': minute,
    };
  }
}

