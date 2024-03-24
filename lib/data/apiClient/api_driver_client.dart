import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApiDriverClient {
  FirebaseAuth firebaseAuth;
  FirebaseFirestore firebaseFirestore;
  ApiDriverClient(this.firebaseAuth, this.firebaseFirestore);

  Future<bool> Login (String email , String password) async{
    var response =  await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return (await firebaseFirestore.collection('drivers').doc(response.user?.uid).get()).exists;
  }

}