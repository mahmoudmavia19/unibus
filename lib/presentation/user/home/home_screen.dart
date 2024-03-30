import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unibus/core/app_export.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/presentation/comapny/chat_center/model/chat_model.dart';
import 'package:unibus/presentation/user/home/controller/home_controller.dart';

class HomeScreen  extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
         child: Obx(()=> controller.state.value.getScreenWidget(_body(), (){})),
       ) ,
    );
  }

  _body()=>ListView.builder(
    itemCount: controller.companies.length,
    itemBuilder:(context, index) {
      var company = controller.companies[index];
      return Card(
      child: ListTile(
        title: Row(
          children: [
            Expanded(child: Text(company.name??'',style: TextStyle(fontWeight: FontWeight.bold,color:theme.primaryColor),)),
            IconButton(onPressed: (){
              Get.toNamed(AppRoutes.chatRoomScreen,arguments:company);
            }, icon: Row(
              children: [
                Icon(Icons.chat_bubble,color: theme.primaryColor,),
                Text('Chat',style: TextStyle(color: theme.primaryColor,fontWeight: FontWeight.bold),)
              ],
            ))
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.0,),
            Row(
              children: [
                Icon(Icons.email,color: theme.primaryColor,),
                SizedBox(width: 10.0,),
                Text(company.email??''),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              children: [
                Icon(Icons.phone,color: theme.primaryColor,),
                SizedBox(width: 10.0,),
                Text(company.phone??''),
              ],
            ),
            Row(
              children: [
                Spacer(),
                TextButton(onPressed: (){
                  Get.toNamed(AppRoutes.userCompanyDistrictsScreen,arguments: company);
                }, child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Booking Now',style: TextStyle(fontSize: 16.0),),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),)
              ],
            ),
            SizedBox(height: 10.0,), Text('${DateFormat.yMMMd().format(DateTime.now())}',style: TextStyle(color: Colors.black26,fontSize: 14.0),),
          ],
        ),
      ),
    );
    },
  );
}
