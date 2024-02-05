import 'package:flutter/material.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/widgets/drawer/comapnyDrawer.dart';

import '../../../core/app_export.dart';
import '../../../core/utils/app_strings.dart';
import 'controller/travels_controller.dart';
import 'model/trip.dart';

class TripsManagementScreen extends StatelessWidget {
  final TripController tripController = Get.put(TripController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CompanyDrawer(),
      appBar: AppBar(
        title: Text(AppStrings.tripsManagement),
        actions: [
          Image.asset(ImageConstant.imgLogo, width: 50.0,),
        ],
      ),
      body: Obx(() => tripController.state.value.getScreenWidget(_buildTripsList(), (){})),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTrip(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildTripsList() {
    return ListView.builder(
      itemCount: tripController.trips.length,
      itemBuilder: (context, index) {
        Trip trip = tripController.trips[index];
        return ListTile(
          onTap: () => _showTrip(trip),
          title: Text(trip.enterGate??""),
          subtitle: Text(trip.driver??""),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => _editTrip(context, index, trip),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteTrip(index),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showTrip(Trip trip) {
    Get.defaultDialog(
      title: trip.enterGate??"",
      content: SingleChildScrollView(
        child: Form(
          key: tripController.addFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildText(AppStrings.location, trip.enterGate??""),
              _buildText(AppStrings.driver, trip.driver??""),
              _buildText(AppStrings.time, trip.time.toString()),
             ],
          ),
        ),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: Text(AppStrings.cancelButtonText),
      ),
    );
  }

  Widget _buildText(String label, String value) {
    return Row(
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 10.0),
        Text(value),
      ],
    );
  }

  void _addTrip(BuildContext context) {
    Get.toNamed(AppRoutes.companyAddTripScreen);
  }

  void _editTrip(BuildContext context, int index, Trip trip) {
   Get.toNamed(AppRoutes.companyEditTripScreen,arguments:[index,trip]);
  }

  void _deleteTrip(int index) {
    tripController.deleteTrip(index);
   }
}