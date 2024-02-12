import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unibus/core/app_export.dart';
import 'package:unibus/core/utils/app_strings.dart';
import 'package:unibus/presentation/comapny/chat_center/controller/chat_center_controller.dart';
import 'package:unibus/widgets/drawer/comapnyDrawer.dart';

class ChatCenterScreen extends GetWidget<ChatCenterController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CompanyDrawer(),
      appBar: AppBar(
        title: Text(AppStrings.chatCenter),
        actions: [
          Image.asset(ImageConstant.imgLogo,),
        ],
      ),
      body:DefaultTabController(length: 2,
          child:Column(
            children: [
              TabBar(tabs:[
                Tab(text: AppStrings.student,),
                Tab(text: AppStrings.employee,),
              ]),
              Expanded(
                child: TabBarView(children:[
                  _tab1(),
                  _tab2(),
                ]),
              ),
            ],
          ))
    );
  }

  _tab1()=>Column(
    children: [
      Expanded(
        child: ListView.builder(
          itemCount: controller.chats.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  title: Text(controller.chats[index].title,style: TextStyle(fontWeight: FontWeight.bold,color: theme.primaryColor),),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(controller.chats[index].lastMessage),
                      Text(DateFormat.yMMMd().format(controller.chats[index].lastMessageTime), style: TextStyle(fontSize: 12,color: Colors.grey),),
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigate to the chat room when tapped
                    Get.toNamed(AppRoutes.companyChatRoom,arguments: controller.chats[index]);
                  },
                ),
                Divider()
              ],
            );
          },
        ),
      ),
    ],
  );
  _tab2()=>Column(
    children: [
      Expanded(
        child: ListView.builder(
          itemCount: controller.chats.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  title: Text(controller.chats[index].title,style: TextStyle(fontWeight: FontWeight.bold,color: theme.primaryColor),),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(controller.chats[index].lastMessage),
                      Text(DateFormat.yMMMd().format(controller.chats[index].lastMessageTime), style: TextStyle(fontSize: 12,color: Colors.grey),),
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigate to the chat room when tapped
                    Get.toNamed(AppRoutes.companyChatRoom,arguments: controller.chats[index]);
                  },
                ),
                Divider()
              ],
            );
          },
        ),
      ),
    ],
  );
}
