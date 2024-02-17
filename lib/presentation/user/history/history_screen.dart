import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../../../core/app_export.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                leading: Icon(Icons.bus_alert_outlined,size: 30,color:PrimaryColors().primary2,),
                title: Text('Driver name',style: TextStyle(color: theme.primaryColor,fontWeight: FontWeight.bold),),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.0,),
                    Text('Trip number $index',),
                    SizedBox(height: 10.0,),
                    Row(
                      children: [
                        Icon(Icons.star,color: Colors.amber,),
                        Icon(Icons.star,color: Colors.amber,),
                        Icon(Icons.star,color: Colors.amber,),
                        Icon(Icons.star,color: Colors.grey,),
                        Icon(Icons.star,color: Colors.grey,),
                      ],
                    ),
                    SizedBox(height: 10.0,),
                    Row(
                      children: [
                        Text(DateFormat.yMMMd().format(DateTime.now()),style: TextStyle(color:Colors.grey,fontSize: 12),),
                        SizedBox(width: 5.0,),
                        Text(DateFormat.Hm().format(DateTime.now()),style: TextStyle(color:Colors.grey,fontSize: 12),),
                      ],
                    )
                  ],
                ),
                trailing: TextButton(onPressed: (){
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
                            Text('Driver Name',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0
                            ),),
                          ],
                        ),
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    )
                      ],
                    ),
                    actions: [
                      TextButton(onPressed: (){
                        Get.back();
                      }, child: Text('Cancel')),
                      TextButton(onPressed: (){

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
}
