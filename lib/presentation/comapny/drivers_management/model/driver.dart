import 'package:unibus/data/models/rate.dart';

class Driver {
  String? name;
  String? uid;
  String? companyId;
  String? address;
  String? phone;
  String? email;
  DriverRate? rate;

  Driver({
    required this.name,
      this.uid,
      this.companyId,
    required this.address,
    required this.phone,
    required this.email,
   });
  Driver.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uid = json['uid'];
    companyId = json['companyId'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
    rate = json['rate']!=null?DriverRate.fromJson(json['rate']):null;
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
     };
   }

}