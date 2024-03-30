import 'package:unibus/presentation/admin/users_manage/model/user_model.dart';

class Request {
  String? uid;
  String? tripID;
  String? companyId;
  String? userId;
  int? status;
  DateTime? date;
  Payment? payment;
  UserModel? user;

  Request(
      {this.uid,
        this.tripID,
        this.companyId,
        this.userId,
        this.status,
        this.date,
        this.payment});

  Request.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    tripID = json['tripID'];
    companyId = json['companyId'];
    userId = json['userId'];
    status = json['status'];
    date = DateTime.tryParse(json['date']);
    payment =
    json['payment'] != null ? Payment.fromJson(json['payment']) : null;
  }

  toJson() {
    return {
      'uid': uid,
      'tripID': tripID,
      'companyId': companyId,
      'userId': userId,
      'status': status,
      'date': date?.toIso8601String(),
      'payment': payment?.toJson(),
    };
  }
}
class Payment {
  String? method;
  double? amount;
  String? cardNumber;
  String? expiryDate;
  String? cvv;

  Payment({
    this.method,
    this.amount,
    this.cardNumber,
    this.expiryDate,
    this.cvv,
  }) ;
  Payment.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    amount = json['amount'];
    cardNumber = json['cardNumber'];
    expiryDate = json['expiryDate'];
    cvv = json['cvv'];
  }

  toJson() {
    return {
      'method': method,
      'amount': amount,
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'cvv': cvv,
    };
  }


}