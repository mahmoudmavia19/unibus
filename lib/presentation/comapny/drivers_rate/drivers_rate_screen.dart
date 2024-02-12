import 'package:flutter/material.dart';
 import 'package:unibus/core/utils/app_strings.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import '../../../core/app_export.dart';
import '../../../widgets/drawer/comapnyDrawer.dart';
import '../drivers_management/controller/drivers_controller.dart';
import '../drivers_management/model/driver.dart';

class DriversRateScreen extends StatelessWidget {
  final DriverController driverController = Get.put(DriverController());

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
      body: Obx(() => driverController.state.value.getScreenWidget(_buildDriversList(), (){
      })),

    );
  }

  Widget _buildDriversList() {
    return ListView.builder(
      itemCount: driverController.drivers.length,
      itemBuilder: (context, index) {
        Driver driver = driverController.drivers[index];
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap:(){
               },
              title: Row(
                children: [
                  Text(driver.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0,color: theme.primaryColor),),
                  SizedBox(width: 10.0,),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star,color: Colors.amber,),
                        Icon(Icons.star,color: Colors.amber,),
                        Icon(Icons.star,color: Colors.amber,),
                        Icon(Icons.star,color: Colors.grey,),
                        Icon(Icons.star,color: Colors.grey,),
                      ]
                  ),
                ],
              ),
              subtitle:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(driver.email,style: TextStyle(fontSize: 16.0,color: Colors.grey),),
                  Text('Good Driver its a conformable trip with him, thanks for this service',style: TextStyle(fontSize: 16.0),),

                ],
              ),
             ),
            Divider()
          ],
        );
      },
    );
  }
  _showRateDriver(BuildContext context, int index, Driver driver) {
    return Get.defaultDialog(
      titlePadding: EdgeInsets.all(10),
      contentPadding:EdgeInsets.all(20),
      title: driver.name + ' ' + AppStrings.rateDriverTitle,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star,color: Colors.amber,),
              Icon(Icons.star,color: Colors.amber,),
              Icon(Icons.star,color: Colors.amber,),
              Icon(Icons.star,color: Colors.grey,),
              Icon(Icons.star,color: Colors.grey,),
            ]
          ),
          SizedBox(height: 10.0,),
          Text('Rate this driver'),
        ]
      )
    ) ;
  }
}
