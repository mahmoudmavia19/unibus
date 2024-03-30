import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:unibus/core/app_export.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/presentation/user/company_trips/controller/company_trips_controller.dart';

class CompanyTripScreen extends GetWidget<CompanyTripsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text('Company Trips'),
         actions: [
           Image.asset(ImageConstant.imgLogo),
         ],
         leading: IconButton(onPressed: (){
           Get.back();
         }, icon: Icon(Icons.arrow_back_ios)),
       ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
             children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Lottie.asset(AppLottie.free,width: 100) ,
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0,bottom: 10.0),
                    child: Text('Two Days Free',style:TextStyle(color: theme.primaryColor,fontSize: 20.0,fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0,bottom: 40.0),
                    child: SlideCountdownSeparated(
                      duration: const Duration(days: 2),
                      decoration: BoxDecoration(
                          color: theme.primaryColor
                      ),
                    ),
                  )
                ],
              ),

            ],
          ),
          Container(
            padding:EdgeInsets.all(20) ,
            child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'Enter Tip Number',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )
                )
            ),
          ),
          Obx(
              ()=>Expanded(
              child: controller.state.value.getScreenWidget(_body(), (){})
            ),
          )
        ],
      ),
    );
  }

  _body()=>ListView.builder(
    itemCount: controller.trips.length,
    itemBuilder: (context, index) {
      var trip = controller.trips[index];
      return Card(
          child: ListTile(
              title: Row(
                children: [
                  Text('${trip.number}',style:TextStyle(fontWeight: FontWeight.bold,color: theme.primaryColor),),
                  Spacer(),
                  TextButton(onPressed: (){
                    Get.toNamed(AppRoutes.userPaymentScreen,arguments: [trip,controller.price]);
                  }, child: Text('Subscribe Now',style: TextStyle(fontSize: 16.0),))
                ],
              ),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.mode_of_travel,color: theme.primaryColor,),
                        SizedBox(width: 10.0,),
                        Text('trip number : ${trip.number}'),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.timer,color: theme.primaryColor,),
                        SizedBox(width: 10.0,),
                        Text('time : ${DateFormat.jm().format(trip.time!)}'),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.door_sliding_outlined,color: theme.primaryColor,),
                        SizedBox(width: 10.0,),
                        Text('Enter Gate : ${trip.enterGate}'),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.door_sliding_sharp,color: theme.primaryColor,),
                        SizedBox(width: 10.0,),
                        Text('Exit Gate : ${trip.exitGate}'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.person,color: theme.primaryColor,),
                        SizedBox(width: 10.0,),
                        Text('Driver : ${trip.driverModel?.name}'),
                        Spacer(),
                        TextButton(onPressed: (){
                          Get.dialog(
                              Dialog(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text('Driver Details',style:TextStyle(color: theme.primaryColor),),
                                    subtitle: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:[
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Icon(Icons.person,color: theme.primaryColor,),
                                            SizedBox(width: 5.0,),
                                            Text(trip.driverModel?.name??''),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Icon(Icons.email,color: theme.primaryColor,),
                                            SizedBox(width: 5.0,),
                                            Text(trip.driverModel?.email??''),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Icon(Icons.phone,color: theme.primaryColor,),
                                            SizedBox(width: 5.0,),
                                            Text(trip.driverModel?.phone??''),
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: TextButton(onPressed: (){
                                            Get.back();
                                          }, child: Text('close')),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                          );
                        }, child: Text('Details',style: TextStyle(fontSize: 16.0),))
                      ],
                    ),
                  ]
              )
          )
      );
    },);
}
