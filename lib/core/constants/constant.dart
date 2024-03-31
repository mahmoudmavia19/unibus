import 'package:google_maps_flutter/google_maps_flutter.dart';

var startMapLocation = LatLng(21.4321, 40.49792);
var testPath = [LatLng(21.4321, 40.49792), LatLng(21.43203, 40.49828), LatLng(21.43168, 40.49821), LatLng(21.43102, 40.49807), LatLng(21.43093, 40.49798), LatLng(21.43078, 40.49787), LatLng(21.43072, 40.49781), LatLng(21.4307, 40.49776), LatLng(21.43071, 40.49736), LatLng(21.43072, 40.49705), LatLng(21.43072, 40.49686), LatLng(21.43066, 40.4962), LatLng(21.43065, 40.496), LatLng(21.43066, 40.49561), LatLng(21.43068, 40.49503), LatLng(21.43065, 40.4949), LatLng(21.43052, 40.49471), LatLng(21.43029, 40.4945), LatLng(21.43014, 40.49435), LatLng(21.42999, 40.49418), LatLng(21.42984, 40.49395), LatLng(21.42966, 40.49378), LatLng(21.42957, 40.4936), LatLng(21.42958, 40.49348), LatLng(21.42959, 40.49343), LatLng(21.42968, 40.49337), LatLng(21.43036, 40.49257), LatLng(21.43207, 40.49059), LatLng(21.43281, 40.48974), LatLng(21.43382, 40.49074), LatLng(21.43632, 40.49331), LatLng(21.43478, 40.49509), LatLng(21.43471, 40.49502)];

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
