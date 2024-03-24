import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../presentation/admin/companies_management/model/company_model.dart';
import '../../presentation/admin/users_manage/model/user_model.dart';
import '../models/admin.dart';

class ApiAdminClient {
  FirebaseAuth firebaseAuth;
  FirebaseFirestore firebaseFirestore;
  ApiAdminClient(this.firebaseAuth, this.firebaseFirestore);

  Future<bool> Login (String email , String password) async{
    var response =  await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return (await firebaseFirestore.collection('admins').doc(response.user?.uid).get()).exists;
  }

  Future<AdminModel> getProfile () async{
    var response = await firebaseFirestore.collection('admins').doc(firebaseAuth.currentUser?.uid).get();
    return AdminModel.fromJson(response.data()!);
  }

  Future<void> updateProfile (AdminModel admin) async{
    await firebaseFirestore.collection('admins').doc(firebaseAuth.currentUser?.uid).update(admin.toJson());
  }

  Future<void> resetPassword (String password) async{
    await firebaseAuth.currentUser?.updatePassword(password) ;
  }
  Future<List<UserModel>> getUsers () async{
    var response = await firebaseFirestore.collection('users').get();
    return response.docs.map((e) {
      var user = UserModel.fromJson(e.data());
      user.userId = e.id;
      return user;
    }).toList();
  }

  Future<void> blockUser (String userId) async{
    await firebaseFirestore.collection('users').doc(userId).update({'blocked': true});
  }

  Future<void> unblockUser (String userId) async{
    await firebaseFirestore.collection('users').doc(userId).update({'blocked': false});
  }

  Future<List<Company>> getCompany () async{
    var response = await firebaseFirestore.collection('companies').get();
    return response.docs.map((e) {
      var company = Company.fromJson(e.data());
      company.companyId = e.id;
      return company;
    }) .toList();
  }

  Future<void> blockCompany (String companyId) async{
    await firebaseFirestore.collection('companies').doc(companyId).update({'blocked': true});
  }
  Future<void> unblockCompany (String companyId) async{
    await firebaseFirestore.collection('companies').doc(companyId).update({'blocked': false});
  }

  Future<void> forgetPassword (String email) async{
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }
}