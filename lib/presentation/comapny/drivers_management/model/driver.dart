import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:unibus/data/models/rate.dart';

class Driver {
  String? name;
  String? uid;
  String? companyId;
  String? address;
  String? phone;
  String? email;
  DriverRate? rate;
  LatLng ? currentLocation ;


  Driver({
    required this.name,
      this.uid,
      this.companyId,
    this.rate,
    required this.address,
    required this.phone,
    required this.email,
    this.currentLocation
   });
  Driver.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uid = json['uid'];
    companyId = json['companyId'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
    rate = json['rate']!=null?DriverRate.fromJson(json['rate']):null;
    currentLocation = json['currentLocation']!=null?LatLng(
      json['currentLocation']['latitude'],
      json['currentLocation']['longitude']
    ) :null;
   }

   toJson() {
     return {
       'name': name,
       'uid': uid,
       'companyId': companyId,
       'address': address,
       'phone': phone,
       'email': email,
       'rate': rate?.toJson(),
       'currentLocation': currentLocation
     };
   }

}