import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    return response.docs.map((e) => Trip.fromJson(e.data())).toList();
  }

}