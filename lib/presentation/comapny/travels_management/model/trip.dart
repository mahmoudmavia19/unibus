import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:unibus/presentation/comapny/drivers_management/model/driver.dart';

class Trip {
   String? id;
   String? number;
   String? distinct;
   String? companyId;
   String? enterGate;
   String? exitGate;
   LatLng? startLocation;
   LatLng? endLocation;
   String? driver;
   Driver? driverModel;
    List<String>? days;
    DateTime? time ;

   Trip({this.number, this.enterGate, this.exitGate, this.startLocation,
      this.endLocation, this.driver, this.id,this.days , this.time});

   Trip.fromJson(Map<String, dynamic> json) {
     number = json['number'];
     enterGate = json['enterGate'];
     exitGate = json['exitGate'];
     startLocation = json['startLocation'];
     endLocation = json['endLocation'];
     driver = json['driver'];
     id = json['id'];
     distinct = json['district'];
     days = json['days'].cast<String>();
      if(json['time'] is Timestamp) {
        time = json['time'].toDate();
      } else {
        time = json['time']!=null?DateTime.tryParse(json['time']):null;
      }
     companyId = json['companyId'];
   }
   toJson() {
     return {
       'number': number,
       'enterGate': enterGate,
       'exitGate': exitGate,
       'startLocation': startLocation,
       'endLocation': endLocation,
       'driver': driver,
       'id': id,
       'days': days,
       'time': time?.toIso8601String(),
       'companyId': companyId ,
       'district': distinct
     };
   }
}
