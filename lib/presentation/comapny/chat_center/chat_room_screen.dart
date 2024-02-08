import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unibus/core/app_export.dart';
import 'package:unibus/presentation/comapny/chat_center/model/chat_model.dart';

class ChatRoomScreen extends StatelessWidget {
  final ChatModel chat;

  const ChatRoomScreen({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chat.title), // Display the title of the chat room
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 20, // Example message count
              itemBuilder: (context, index) {
                return _buildMessage(index);
              },
            ),
          ),
          _buildMessageInputField(),
        ],
      ),
    );
  }

  Widget _buildMessage(int index) {
    final bool isSentMessage = index % 2 == 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: isSentMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: isSentMessage ? Radius.circular(25) : Radius.circular(0),
                topRight: isSentMessage ? Radius.circular(0) : Radius.circular(25),
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              color: isSentMessage ? theme.primaryColor :Colors.blueGrey,
            ),
            child: Column(
              crossAxisAlignment:  isSentMessage ?CrossAxisAlignment.end:CrossAxisAlignment.start,
              children: [
                Text('Message number $index from chat', style: TextStyle(fontSize: 18,color: theme.secondaryHeaderColor)),
                SizedBox(height: 5.0),
                Text(
                  DateFormat.Hm().format(DateTime.now()),
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInputField() {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border(top: BorderSide(color: Colors.grey)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(width: 8.0),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {

            },
          ),
        ],
      ),
    );
  }
}
