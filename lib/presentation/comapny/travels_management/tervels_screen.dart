import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    return RefreshIndicator(
      onRefresh: () async{
        tripController.getTrips();
      },
      child: ListView.builder(
        itemCount: tripController.trips.length,
        itemBuilder: (context, index) {
          Trip trip = tripController.trips[index];
          return Column(
            children: [
              ListTile(
                onTap: () => _showTrip(trip,context),
                leading: Text(trip.number??"",style: TextStyle(color: theme.primaryColor,fontSize: 16.0),),
      //              title: Text(trip.enterGate??""),
                subtitle:Column(
                   children: [
                      _buildText(AppStrings.driver, tripController.drivers.where((p0) => p0.uid==trip.driver).first.name??""),
                     _buildText(AppStrings.day, trip.days.toString()),
                   ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _editTrip(context, index, trip),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteTrip(trip),
                    ),
                  ],
                ),
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }

  void _showTrip(Trip trip,context) {
    Get.defaultDialog(
      title: trip.number??"",
      content: SingleChildScrollView(
        child: Form(
          key: tripController.addFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildText(AppStrings.tripEntryGate, trip.enterGate??""),
              _buildText(AppStrings.tripExitGate, trip.exitGate??""),
              _buildText(AppStrings.driver, tripController.drivers.where((p0) => p0.uid==trip.driver).first.name??""),
              _buildText(AppStrings.day, trip.days.toString()),
              _buildText(AppStrings.time, DateFormat.jm().format(trip.time!)),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 10.0),
        Expanded(child: Text(value)),
      ],
    );
  }

  void _addTrip(BuildContext context) {
    Get.toNamed(AppRoutes.companyAddTripScreen);
  }

  void _editTrip(BuildContext context, int index, Trip trip) {
   Get.toNamed(AppRoutes.companyEditTripScreen,arguments:[index,trip]);
  }

  void _deleteTrip(Trip trip) {
    tripController.deleteTrip(trip);
   }
}