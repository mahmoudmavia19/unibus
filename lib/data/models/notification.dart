import 'package:cloud_firestore/cloud_firestore.dart';

class Notification {
  String? uid;
  String? title;
  String? body;
  String? tripId;
  DateTime? time;
  Notification({this.title, this.body,this.uid,this.tripId,this.time});
  Notification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    time = (json['time'] as Timestamp).toDate();
    tripId = json['tripId'];
    uid = json['uid'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['tripId'] = this.tripId;
    data['uid'] = this.uid;
    data['body'] = this.body;
    data['time'] = this.time;
    return data;
  }
}