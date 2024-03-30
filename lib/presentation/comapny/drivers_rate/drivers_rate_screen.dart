import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
 import 'package:unibus/core/utils/app_strings.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/presentation/comapny/drivers_rate/controller/driver_rate_controller.dart';
import '../../../core/app_export.dart';
import '../../../widgets/drawer/comapnyDrawer.dart';
import '../drivers_management/model/driver.dart';

class DriversRateScreen extends StatelessWidget {
  final DriverRateController rateController = Get.put(DriverRateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CompanyDrawer(),
      appBar: AppBar(
          title: Text(AppStrings.driversRateTitle),
          actions: [
            Image.asset(ImageConstant.imgLogo, width: 50.0,),
          ]
      ),
      body: Obx(() => rateController.state.value.getScreenWidget(_buildDriversList(), (){
        rateController.driverController.getDrivers();
      })),

    );
  }

  Widget _buildDriversList() {
    return RefreshIndicator(
      onRefresh: () async{
        rateController.driverController.getDrivers();
      },
      child: ListView.builder(
        itemCount: rateController.driverController.drivers.length,
        itemBuilder: (context, index) {
          Driver driver = rateController.driverController.drivers[index];
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Row(
                  children: [
                    Text(driver.name!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0,color: theme.primaryColor),),
                    SizedBox(width: 10.0,),
                    RatingBar.builder(
                      initialRating: driver.rate?.rate??0.0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 25.0,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                       ignoreGestures: true,
                    )

                  ],
                ),
                subtitle:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(driver.email!,style: TextStyle(fontSize: 16.0,color: Colors.grey),),
                    Text(driver.rate?.comment??'',style: TextStyle(fontSize: 16.0),),
                    Text(driver.rate!=null ?DateFormat.yMMMd().format(driver.rate!.date!):'',style: TextStyle(fontSize: 14.0,color: Colors.grey),),

                  ],
                ),
               ),
              Divider()
            ],
          );
        },
      ),
    );
  }
  _showRateDriver(Driver driver) {
    return Get.defaultDialog(
      titlePadding: EdgeInsets.all(10),
      contentPadding:EdgeInsets.all(20),
      title: driver.name! + ' ' + AppStrings.rateDriverTitle,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RatingBar.builder(
            initialRating: driver.rate?.rate??0.0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 25.0,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
            ignoreGestures: true,
          ),
          SizedBox(height: 10.0,),
          Text('Rate this driver'),
        ]
      )
    ) ;
  }
}
