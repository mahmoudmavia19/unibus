
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? id;
  String? senderId;
  String? message ;
  DateTime? messageTime;

  MessageModel({this.senderId,this.message,this.messageTime});

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['senderId'];
    message = json['message'];
    // messageTime  from Timestamp to DateTime
    messageTime = (json['messageTime'] as Timestamp).toDate();
   }
  toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'message': message,
      'messageTime': messageTime
    } ;
  }
}