import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unibus/core/app_export.dart';
import 'package:unibus/data/models/notification.dart';
import 'package:unibus/presentation/admin/companies_management/model/company_model.dart';
import 'package:unibus/presentation/admin/users_manage/model/user_model.dart';
import 'package:unibus/presentation/comapny/chat_center/model/message_model.dart';
import 'package:unibus/presentation/comapny/drivers_management/model/driver.dart';
import 'package:unibus/presentation/comapny/price_management/model/price.dart';
import 'package:unibus/presentation/comapny/travels_management/model/trip.dart';
import 'package:unibus/presentation/user/payment_screen/request/request.dart';

import '../../presentation/comapny/chat_center/model/chat_model.dart';

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

   Future<UserModel> getProfile () async{
     var response = await firebaseFirestore.collection('users').doc(firebaseAuth.currentUser!.uid).get();
     var user = UserModel.fromJson(response.data()!);
     user.userId = response.id ;
     return user;
   }

   Future<void> updateProfile (UserModel user) async{
     await firebaseFirestore.collection('users').doc(user.userId).update(user.toJson());
   }

   Future<void> resetPassword (String password) async{
     await firebaseAuth.currentUser?.updatePassword(password) ;
   }


   Future<List<Company>> getCompany () async{
     var response = await firebaseFirestore.collection('companies').get();
     return response.docs.map((e) {
       var company = Company.fromJson(e.data());
       company.companyId = e.id;
       return company;
     }) .toList();
   }
   Future<void> sendMessage (String companyID,MessageModel messageModel) async{
     await firebaseFirestore
         .collection('companies')
         .doc(companyID)
         .collection('chats')
         .doc(firebaseAuth.currentUser!.uid).set(ChatModel(
       lastMessage: messageModel.message,
       lastMessageTime: messageModel.messageTime,
       senderId: firebaseAuth.currentUser!.uid,
       id: firebaseAuth.currentUser!.uid,
     ).toJson());
     messageModel.senderId = firebaseAuth.currentUser!.uid;
     await firebaseFirestore.collection('companies').doc(companyID).collection('chats').doc(firebaseAuth.currentUser!.uid).collection('messages').add(messageModel.toJson());
   }

   Future<Stream<List<MessageModel>>> getMessages(String companyId) async {
     try {
       final snapshot = await firebaseFirestore
           .collection('companies')
           .doc(companyId)
           .collection('chats')
           .doc(firebaseAuth.currentUser!.uid)
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

   Future<List<Trip>> getTrips (String companyId,String districtId)async{
     var response = await firebaseFirestore.collection('trips').where('companyId',isEqualTo: companyId)
         .where('district',isEqualTo: districtId).get();
     return response.docs.map((e) {
       var trip = Trip.fromJson(e.data());
       trip.id = e.id;
       return trip;
     }) .toList(); 
   }
   Future<Driver> getDriver (String driver)async{
     var response = await firebaseFirestore.collection('drivers').doc(driver).get();
     return Driver.fromJson(response.data()!);
   }

   Future<void> subscribe(Request request) async{
      request.userId = firebaseAuth.currentUser!.uid;
     await firebaseFirestore.collection('requests').add(request.toJson());
   }

   Future<List<Price>> getPrice (String companyId) async{
     var response = await firebaseFirestore.collection('prices')
         .where('companyId',isEqualTo: companyId).get();
     return response.docs.map((e) {
       var price = Price.fromJson(e.data());
       price.uid = e.id;
       return price;
     }) .toList();
   }
   
   Future<List<Driver>> getDriversOfRequests () async{
     List<Driver> drivers = [];
     var response = await firebaseFirestore.collection('requests')
         .where('userId',isEqualTo: firebaseAuth.currentUser?.uid)
         .where('status',isEqualTo: 1).get();
     for(var request in response.docs) {
       if (request.data()['driverId'] != null) {
               var driver = await getDriver(request.data()['driverId']);
                drivers.add(driver);
           }
     }
     return drivers;
   }
   Future<void> addRate (Driver driver) async{
     await firebaseFirestore.collection('drivers').doc(driver.uid).update(driver.toJson());
   }

   // stream of notifications
  Stream<List<Notification>> getNotifications(){
    return firebaseFirestore.collection('notifications')
    .orderBy('time',descending: true)
    /*.where('userId',isEqualTo: firebaseAuth.currentUser?.uid)
       */ .snapshots().map(
          (event) => event.docs.map(
            (e) {
              var notification = Notification.fromJson(e.data());
              notification.uid = e.id;
              return notification;
            },
          ).toList(),
        );
  }

   Stream<Driver> getDriverStream(driverId) {
     return firebaseFirestore
         .collection('drivers')
         .doc(driverId)
         .snapshots()
         .map((doc) => Driver.fromJson(doc.data()!));
   }

   Future<Trip?> getCurrentTrip() async {
     try {
       var currentTripSnapshot =
       await firebaseFirestore.collection('CurrentTrips').get();
       var requestsSnapshot = await firebaseFirestore
           .collection('requests')
           .where('userId', isEqualTo: firebaseAuth.currentUser?.uid)
           .where('status', isEqualTo: 1)
           .get();
       int reqlen = requestsSnapshot.docs.length;
       int curlen = currentTripSnapshot.docs.length;
       for (var request in requestsSnapshot.docs) {
         var tripId = request.data()['tripID'];
         var tripSnapshot = currentTripSnapshot.docs.where(
               (element) => element.id == tripId,).toList()[0];
           return Trip.fromJson(tripSnapshot.data());
       }
       return null; // No trip found
     } catch (e) {
       print('Error fetching current trip: $e');
       return null;
     }
   }




}
