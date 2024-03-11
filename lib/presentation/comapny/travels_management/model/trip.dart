import 'package:google_maps_flutter/google_maps_flutter.dart';

class Trip {
   String? id;
   String? number;
   String? enterGate;
   String? exitGate;
   LatLng? startLocation;
   LatLng? endLocation;
   String? driver;
    List<String>? days;
    DateTime? time ;




   Trip({this.number, this.enterGate, this.exitGate, this.startLocation,
      this.endLocation, this.driver, this.id,this.days , this.time});
}
