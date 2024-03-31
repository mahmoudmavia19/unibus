import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/data/models/rate.dart';
import 'package:unibus/presentation/comapny/drivers_management/model/driver.dart';
import 'package:unibus/presentation/user/history/controller/history_controller.dart';

import '../../../core/app_export.dart';

class HistoryScreen extends GetWidget<HistoryController>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>controller.flowState.value.getScreenWidget(_body(), (){
        controller.getDriverHistory();
      })),
    );
  }

  _body()=>RefreshIndicator(
    onRefresh: () async{
      controller.getDriverHistory();
    },
    child: ListView.builder(
      itemCount: controller.drivers.length,
      itemBuilder: (context, index) {
        var driver = controller.drivers[index];
        return Column(
          children: [
            ListTile(
              leading: Icon(Icons.bus_alert_outlined,size: 30,color:PrimaryColors().primary2,),
              title: Text(driver.name??'',style: TextStyle(color: theme.primaryColor,fontWeight: FontWeight.bold),),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    SizedBox(height: 10.0,),
                  RatingBar.builder(
                    ignoreGestures: true,
                    onRatingUpdate: (value) {},
                    initialRating: driver.rate?.rate??0.0,
                     direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 20.0,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    )
                  ),
                  SizedBox(height: 10.0,),
                  Visibility(
                    visible: driver.rate?.rate!=null,
                    child: Row(
                      children: [
                        Text(DateFormat.yMMMd().format(driver.rate?.date??DateTime.now()),style: TextStyle(color:Colors.grey,fontSize: 12),),
                        SizedBox(width: 5.0,),
                        Text(DateFormat.Hm().format(driver.rate?.date??DateTime.now()),style: TextStyle(color:Colors.grey,fontSize: 12),),
                      ],
                    ),
                  )
                ],
              ),
              trailing: TextButton(onPressed: (){
                double rate= 0.0 ;
                Get.dialog(AlertDialog(
                  title: Text('Driver Rate'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.drive_eta_rounded,size: 30,color: theme.primaryColor,),
                          SizedBox(width: 10.0,),
                          Text(driver.name??'',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0
                          ),),
                        ],
                      ),
                      RatingBar.builder(
                        initialRating: driver.rate?.rate??0.0,
                         direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          rate = rating;
                        },
                      )
                    ],
                  ),
                  actions: [
                    TextButton(onPressed: (){
                      Get.back();
                    }, child: Text('Cancel')),
                    TextButton(onPressed: (){
                      Driver dr = Driver(
                        uid: driver.uid,
                        name: driver.name,
                        email: driver.email,
                        address: driver.address ,
                        phone: driver.phone,
                        companyId: driver.companyId,
                        rate: DriverRate(
                          rate: rate ,
                          companyId: driver.companyId,
                          driverId: driver.uid,
                          date: DateTime.now(),
                           comment: 'some comment'
                        )
                      );
                      controller.addRate(dr);
                      Get.back();
                    }, child: Text('Rate')),
                  ],
                ),);
              }, child: Text('Rate')),
            ),
            Divider(color: Colors.grey,endIndent: 20,indent: 20,)
          ],
        );
      },),
  );
}
