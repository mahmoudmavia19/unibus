import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:searchfield/searchfield.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:unibus/core/app_export.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/presentation/comapny/price_management/model/price.dart';
import 'package:unibus/presentation/user/company_district/controller/company_district_controller.dart';

class CompanyDistrictScreen extends GetWidget<CompanyDistrictController> {
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
          Obx(
           ()=>Container(
              padding:EdgeInsets.all(20) ,
              child:  SearchField<Price>(
                suggestions: controller.prices
                    .map(
                      (e) => SearchFieldListItem<Price>(
                    e.district.toString(),
                    item: e,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(e.district.toString()),
                    ),
                  ),
                ).toList(),
                onSuggestionTap: (p0) {
                  Get.toNamed(AppRoutes.userCompanyTripsScreen,arguments: [controller.company,p0.item]);
                },
                searchInputDecoration:  InputDecoration(
                    hintText: 'Enter District Name',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )
                ),
              ),
            ),
          ),
          Expanded(
            child:Obx(()=>controller.state.value.getScreenWidget(_body(), (){
              controller.getPrices();
            })) ,
          )
        ],
      ),
    );
  }
  _body()=>ListView.builder(
    itemCount: controller.prices.length,
    itemBuilder: (context, index) {
      var price = controller.prices[index];
      return Card(
          child: ListTile(
              title: Text(price.district??'',style:TextStyle(fontWeight: FontWeight.bold,color: theme.primaryColor),),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                     Row(
                      children: [
                        Icon(Icons.price_change_outlined,color: theme.primaryColor,),
                        SizedBox(width: 10.0,),
                        Text('Price : \$${price.price}'),
                        Spacer(),
                        TextButton(onPressed: (){
                          Get.toNamed(AppRoutes.userCompanyTripsScreen,arguments: [controller.company,price]);
                        }, child: Text('Show Trips',style: TextStyle(fontSize: 16.0),))
                      ],
                    ),
                    SizedBox(height: 10.0,),
                  ]
              )
          )
      );
    },);
}
