import 'package:google_maps_flutter/google_maps_flutter.dart';

var startMapLocation = LatLng(37.42796133580664, -122.085749655962);

bool passwordValidation (String password){
  RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  return regex.hasMatch(password);

}

bool emailValidation(String email){
  RegExp regex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
  return regex.hasMatch(email);
}

bool phoneValidation(String phone){
  RegExp regex = RegExp(r'^05\d{8}$');
  return regex.hasMatch(phone);
}

bool nameValidation(String name){
  RegExp regex = RegExp(r'^[a-zA-Z]+$');
  return regex.hasMatch(name);
}
