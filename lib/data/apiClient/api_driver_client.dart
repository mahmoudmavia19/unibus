import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:unibus/data/models/notification.dart';
import 'package:unibus/presentation/comapny/travels_management/model/trip.dart';

class ApiDriverClient {
  FirebaseAuth firebaseAuth;
  FirebaseFirestore firebaseFirestore;
  ApiDriverClient(this.firebaseAuth, this.firebaseFirestore);

  Future<bool> Login (String email , String password) async{
    var response =  await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return (await firebaseFirestore.collection('drivers').doc(response.user?.uid).get()).exists;
  }

  Future<List<Trip>> getTrips()async{
    var response = await firebaseFirestore.collection('trips').where('driver',isEqualTo: firebaseAuth.currentUser?.uid).get();
    return response.docs.map((e) {
      var trip = Trip.fromJson(e.data());
      trip.id = e.id;
      return trip ;
    }).toList();
  }

  Future<void> shareMyLocation(LatLng latLng) async {
    await firebaseFirestore.collection('drivers').doc(firebaseAuth.currentUser!.uid).update(
        {'currentLocation': {
          'latitude': latLng.latitude,
          'longitude': latLng.longitude
        }});
  }
  sendNotification(Notification notification) async {
    await firebaseFirestore.collection('notifications').add(notification.toJson());
   }

   startCurrentTrip(Trip trip) async {
    await firebaseFirestore.collection('CurrentTrips').doc(trip.id).set(trip.toJson());
   }
   endCurrentTrip(Trip trip) async {
    await firebaseFirestore.collection('CurrentTrips').doc(trip.id).delete();
   }

}