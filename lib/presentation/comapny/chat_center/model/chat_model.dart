import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
   String? id;
    String? title;
   String? lastMessage;
   DateTime? lastMessageTime;
   String? senderId ;

  ChatModel({this.title,this.lastMessage,this.lastMessageTime,this.senderId,this.id});

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['senderId'];
      lastMessage = json['lastMessage'];
    lastMessageTime = (json['lastMessageTime'] as Timestamp).toDate();

  }
   toJson() {
     return {
       'id': id,
       'lastMessage': lastMessage,
       'lastMessageTime': lastMessageTime,
       'senderId': senderId,
     } ;
   }
}
