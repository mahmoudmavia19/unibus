import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unibus/core/app_export.dart';
import 'package:unibus/presentation/admin/users_manage/model/user_model.dart';

class ApiClient extends GetConnect {
   FirebaseAuth firebaseAuth ;
   FirebaseFirestore firebaseFirestore;

   ApiClient(this.firebaseAuth, this.firebaseFirestore);

   Future<void> Register (UserModel userModel, String password) async{
      var response =  await firebaseAuth.createUserWithEmailAndPassword(email: userModel.email!, password: password);
      userModel.userId = response.user!.uid;
     return await firebaseFirestore.collection('users').doc(response.user!.uid).set(userModel.toJson());
   }

   Future<bool> Login (String email , String password) async{
      var response =  await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return (await firebaseFirestore.collection('users').doc(response.user?.uid).get()).exists;
   }


}
