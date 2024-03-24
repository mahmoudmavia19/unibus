import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unibus/core/app_export.dart';
import 'package:unibus/presentation/admin/companies_management/model/company_model.dart';
import 'package:unibus/presentation/admin/users_manage/model/user_model.dart';

class ApiCompanyClient extends GetConnect {
  FirebaseAuth firebaseAuth ;
  FirebaseFirestore firebaseFirestore;

  ApiCompanyClient(this.firebaseAuth, this.firebaseFirestore);

  Future<void> Register (Company userModel, String password) async{
    var response =  await firebaseAuth.createUserWithEmailAndPassword(email: userModel.email!, password: password);
    userModel.companyId = response.user!.uid;
    return await firebaseFirestore.collection('companies').doc(response.user!.uid).set(userModel.toJson());
  }

  Future<bool> Login (String email , String password) async{
    var response =  await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return (await firebaseFirestore.collection('companies').doc(response.user?.uid).get()).exists;
  }


}
