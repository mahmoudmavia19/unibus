import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unibus/core/app_export.dart';
import 'package:unibus/presentation/admin/companies_management/model/company_model.dart';
import 'package:unibus/presentation/admin/users_manage/model/user_model.dart';
import 'package:unibus/presentation/comapny/chat_center/model/chat_model.dart';
import 'package:unibus/presentation/comapny/travels_management/model/trip.dart';
import 'package:unibus/presentation/user/payment_screen/request/request.dart';
import '../../presentation/comapny/chat_center/model/message_model.dart';
import '../../presentation/comapny/drivers_management/model/driver.dart';
import '../../presentation/comapny/price_management/model/price.dart';

class ApiCompanyClient extends GetConnect {
  FirebaseAuth firebaseAuth ;
  FirebaseFirestore firebaseFirestore;
  static String? companyId ;

  ApiCompanyClient(this.firebaseAuth, this.firebaseFirestore);

  Future<void> Register (Company userModel, String password) async{
    var response =  await firebaseAuth.createUserWithEmailAndPassword(email: userModel.email!, password: password);
    userModel.companyId = response.user!.uid;
    companyId = response.user!.uid;
    return await firebaseFirestore.collection('companies').doc(response.user!.uid).set(userModel.toJson());
  }

  Future<bool> Login (String email , String password) async{
    var response =  await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    companyId = response.user?.uid;
    return (await firebaseFirestore.collection('companies').doc(response.user?.uid).get()).exists;
  }
  Future<Company> getProfile () async{
    var response = await firebaseFirestore.collection('companies').doc(companyId).get();
    var company = Company.fromJson(response.data()!);
    company.companyId = response.id ;
    return company;
  }

  Future<void> updateProfile (Company company) async{
    await firebaseFirestore.collection('companies').doc(companyId).update(company.toJson());
  }

  Future<void> resetPassword (String password) async{
    await firebaseAuth.currentUser?.updatePassword(password) ;
  }

  Future<List<Price>> getPrices () async{
    var response = await firebaseFirestore.collection('prices').where('companyId',isEqualTo: companyId).get();
    return response.docs.map((e) {
      var price = Price.fromJson(e.data());
      price.uid = e.id;
      return price;
    }) .toList();
  }

  Future<void> addPrice (Price price) async{
    price.companyId = companyId;
    await firebaseFirestore.collection('prices').add(price.toJson());
  }
  Future<void> updatePrice (Price price) async{
    await firebaseFirestore.collection('prices').doc(price.uid).update(price.toJson());
  }
  Future<void> deletePrice (Price price) async{
    await firebaseFirestore.collection('prices').doc(price.uid).delete();
  }

  Future<void> addDriver (Driver driver,String password) async{
    driver.companyId = companyId;
    var response = await firebaseAuth.createUserWithEmailAndPassword(email: driver.email!, password: password) ;
    driver.uid = response.user!.uid;
    return await firebaseFirestore.collection('drivers').doc(response.user!.uid).set(driver.toJson());
  }

  Future<void> updateDriver (Driver driver) async{
    await firebaseFirestore.collection('drivers').doc(driver.uid).update(driver.toJson());
  }

  Future<void> deleteDriver (Driver driver) async{
    await firebaseFirestore.collection('drivers').doc(driver.uid.toString()).delete();
  }

  Future<List<Driver>> getDrivers () async{
    var response = await firebaseFirestore.collection('drivers').where('companyId',isEqualTo: companyId).get();
    return response.docs.map((e) {
      var driver = Driver.fromJson(e.data());
      driver.uid = e.id;
      return driver;
    }) .toList();
  }

  Future<void> addRate (Driver driver) async{
    await firebaseFirestore.collection('drivers').doc(driver.uid).update(driver.toJson());
  }


  Future<List<Trip>> getTrips () async{
    var response = await firebaseFirestore.collection('trips').where('companyId',isEqualTo: companyId).get();
    return response.docs.map((e) {
      var trip = Trip.fromJson(e.data());
      trip.id = e.id;
      return trip;
    }) .toList();
  }

  Future<void> addTrip (Trip trip) async{
    trip.companyId = companyId;
    await firebaseFirestore.collection('trips').add(trip.toJson());
  }

  Future<void> updateTrip (Trip trip) async{
    await firebaseFirestore.collection('trips').doc(trip.id).update(trip.toJson());
  }

  Future<void> deleteTrip (Trip trip) async{
    await firebaseFirestore.collection('trips').doc(trip.id).delete();
  }

  Future<List<UserModel>> getUsers () async{
    var response = await firebaseFirestore.collection('users').get();
    return response.docs.map((e) {
      var user = UserModel.fromJson(e.data());
      user.userId = e.id;
      return user;
    }) .toList();
  }

  Future<UserModel> getUser(userID) async{
    var response = await firebaseFirestore.collection('users').doc(userID).get();
    return UserModel.fromJson(response.data()!);
  }

  Future<Stream<List<MessageModel>>> getMessages(String userId) async {
    try {
      final snapshot = await firebaseFirestore
          .collection('companies')
          .doc(companyId)
          .collection('chats')
          .doc(userId)
          .collection('messages').orderBy('messageTime', descending: true)
          .snapshots();

      Stream<List<MessageModel>> messageStream = snapshot.map(
            (event) => event.docs.map(
              (e) {
            var message = MessageModel.fromJson(e.data());
            message.id = e.id;
            return message;
          },
        ).toList(),
      );

      return messageStream;
    } catch (e) {
      // Handle errors appropriately, such as logging or rethrowing
      throw e;
    }
  }

  Future<Stream<List<ChatModel>>> getChats() async {
    try {
      final snapshot = await firebaseFirestore
          .collection('companies')
          .doc(companyId)
          .collection('chats')
          .orderBy('lastMessageTime', descending: true)
          .snapshots();

      Stream<List<ChatModel>> chatsStream = snapshot.map(
            (event) =>
            event.docs.map(
                  (e) {
                var chat = ChatModel.fromJson(e.data());
                chat.id = e.id;
                return chat;
              },
            ).toList(),
      );
      return chatsStream;
    } catch (e) {
      // Handle errors appropriately, such as logging or rethrowing
      throw e;
    }
  }

  Future<void> sendMessage(MessageModel message,String userID) async {
    await firebaseFirestore
        .collection('companies')
        .doc(companyId)
        .collection('chats')
        .doc(userID).set(ChatModel(
      lastMessage: message.message,
      lastMessageTime: message.messageTime,
      senderId: companyId,
      id: userID
    ).toJson());
    message.senderId = companyId;
    await firebaseFirestore
        .collection('companies')
        .doc(companyId)
        .collection('chats')
        .doc(userID)
        .collection('messages')
        .add(message.toJson());
  }

  Future<List<Request>> getRequests () async{
    var response = await firebaseFirestore.collection('requests').where('companyId',isEqualTo: companyId).get();
    return response.docs.map((e) {
      var request = Request.fromJson(e.data());
      request.uid = e.id;
      return request;
    }) .toList();
  }
  Future<Request> updateRequest (Request request) async{
    await firebaseFirestore.collection('requests').doc(request.uid).update(request.toJson());
    return request;
  }
}
