import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:unibus/core/constants/constant.dart';
import 'package:get/get.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'dart:math';
import 'package:unibus/data/remote_data_source/remote_data_source.dart';
import 'package:unibus/presentation/comapny/drivers_management/model/driver.dart';
import 'package:unibus/presentation/comapny/travels_management/model/trip.dart';

class MapTripController extends GetxController {
  Rx<FlowState> state = Rx<FlowState>(ContentState());
  final Rx<LocationData> startLocation = Rx(LocationData.fromMap({
    'latitude': testPath.first.latitude,
    'longitude': testPath.first.longitude,
  }));
  final Rx<LocationData> endLocation = Rx(LocationData.fromMap({
    'latitude': testPath.last.latitude,
    'longitude': testPath.last.longitude,
  }));
  late GoogleMapController mapController;
  RemoteDataSource remoteDataSource = Get.find<RemoteDataSourceImpl>();
  List<LatLng> polylineCoordinates = [];
Rx<Trip?> trip = Rx<Trip?>(null);
Rx<Driver?> driver = Rx<Driver?>(null);
  @override
  void onInit() async{
    await getCurrentTrip();
    getPolyPoints();
    super.onInit();
  }

  Future<void> getCurrentTrip ()async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.getCurrentTrip()).fold((l) {
      state.value = ErrorState(StateRendererType.fullScreenErrorState,l.message);
    }, (r) {
      trip.value = r;
      if(trip.value == null){
        state.value =EmptyState('No Trip Found');
      }
      else {
        state.value = ContentState();
        startDriverTracking();
      }
    });
  }

  @override
  void onReady() {
    super.onReady();

  }
  Future<void>startDriverTracking() async{
    (await remoteDataSource.getDriverStream(trip.value!.driver!)).listen((event) {
      event.fold((l){}, (r) {
        driver.value = r;
        print(r.uid);
        updateLocations();
      });
    });
  }

  void startUpdatingLocations() {
    Get.snackbar('Trip Alert', 'Trip started');
  }

  double calculateDistance(LatLng point1, LatLng point2) {
    const double earthRadius = 6371000; // in meters

    // Convert latitude and longitude from degrees to radians
    double lat1Rad = degreesToRadians(point1.latitude);
    double lon1Rad = degreesToRadians(point1.longitude);
    double lat2Rad = degreesToRadians(point2.latitude);
    double lon2Rad = degreesToRadians(point2.longitude);

    // Haversine formula
    double deltaLat = lat2Rad - lat1Rad;
    double deltaLon = lon2Rad - lon1Rad;
    double a = sin(deltaLat / 2) * sin(deltaLat / 2) +
        cos(lat1Rad) * cos(lat2Rad) * sin(deltaLon / 2) * sin(deltaLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    return distance;
  }

  double degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }


  void updateLocations() {
    // Update start location coordinates (move towards end location)
    if (startLocation.value.latitude! < endLocation.value.latitude!) {
      startLocation.value = LocationData.fromMap({
        'latitude': startLocation.value.latitude! + 0.0001,
        'longitude': startLocation.value.longitude! + 0.0001,
      });
      print(calculateDistance(
          LatLng(startLocation.value.latitude!, startLocation.value.longitude!),
          LatLng(endLocation.value.latitude!, endLocation.value.longitude!)));
      if (calculateDistance(
          LatLng(startLocation.value.latitude!, startLocation.value.longitude!),
          LatLng(endLocation.value.latitude!, endLocation.value.longitude!)) ==
          113.59036586978884) {
        Get.snackbar('Trip Alert', 'Trip very close');
      }


      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 16,
            target: LatLng(
                startLocation.value.latitude!, startLocation.value.longitude!),
          ),
        ),
      );
      update();
    }
  }


  void getPolyPoints() {
    polylineCoordinates =  testPath;

    /*add(LatLng(startLocation.value.latitude!, startLocation.value.longitude!));
    polylineCoordinates.add(LatLng(21.432294, 40.496486));
    polylineCoordinates.add(LatLng(21.431998, 40.497730));
    polylineCoordinates.add(LatLng(21.432087, 40.497891));
    polylineCoordinates.add(LatLng(21.432094, 40.497978));
    polylineCoordinates.add(LatLng(21.432037, 40.498268));
     polylineCoordinates.add(LatLng(endLocation.value.latitude!, endLocation.value.longitude!));*/
  }
}

