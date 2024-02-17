import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:unibus/core/app_export.dart';

class CompanyDistrictScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Districts'),
        actions: [
          Image.asset(ImageConstant.imgLogo),
        ],
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        children: [
          Container(
            color: PrimaryColors().primary2,
            child: Row(
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
          ),
          Container(
            padding:EdgeInsets.all(20) ,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter District Name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                )
              )
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                        title: Text('District name',style:TextStyle(fontWeight: FontWeight.bold,color: theme.primaryColor),),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Icon(Icons.mode_of_travel,color: theme.primaryColor,),
                                  SizedBox(width: 10.0,),
                                  Text('trips ${index+1}'),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.price_change_outlined,color: theme.primaryColor,),
                                  SizedBox(width: 10.0,),
                                  Text('Price : \$${(index+1)*5}'),
                                  Spacer(),
                                  TextButton(onPressed: (){
                                    Get.toNamed(AppRoutes.userCompanyTripsScreen);
                                  }, child: Text('Show Trips',style: TextStyle(fontSize: 16.0),))
                                ],
                              ),
                            ]
                        )
                    )
                );
              },),
          )
        ],
      ),
    );
  }
}
