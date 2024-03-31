import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unibus/presentation/comapny/drivers_management/model/driver.dart';

class DriverRate {
   String? driverId ;
   String? companyId ;
  double? rate ;
  String? comment ;
  DateTime? date ;
  Driver? driver ;
   DriverRate({
     this.driverId,
     this.rate,
     this.comment,
     this.date,
     this.driver,
     this.companyId,
    });

  DriverRate.fromJson(Map<String, dynamic> json) {
     driverId = json['driverId'];
    rate = json['rate'];
    comment = json['comment'];
    date = (json['date'] as Timestamp).toDate();
     companyId = json['companyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
     data['driverId'] = this.driverId;
    data['rate'] = this.rate;
    data['comment'] = this.comment;
    data['date'] = this.date;
     data['companyId'] = this.companyId;
    return data;
  }


}
