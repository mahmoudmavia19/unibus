
import 'package:dartz/dartz.dart';
import 'package:unibus/core/errors/error_handler.dart';
import 'package:unibus/core/errors/failure.dart';
import 'package:unibus/data/models/rate.dart';
import 'package:unibus/presentation/admin/companies_management/model/company_model.dart';
import 'package:unibus/presentation/admin/users_manage/model/user_model.dart';
import 'package:unibus/presentation/comapny/chat_center/model/chat_model.dart';
import 'package:unibus/presentation/comapny/drivers_management/model/driver.dart';
import 'package:unibus/presentation/comapny/travels_management/model/trip.dart';
import 'package:unibus/presentation/user/payment_screen/request/request.dart';

import '../../core/network/network_info.dart';
import '../../presentation/comapny/chat_center/model/message_model.dart';
import '../../presentation/comapny/price_management/model/price.dart';
import '../apiClient/api_company_client.dart';

abstract class CompanyRemoteDataSource{
  Future<Either<Failure,bool>> login(String email, String password);
  Future<Either<Failure,void>> register(Company userModel, String password);
  Future<Either<Failure,void>> updateProfile(Company company);
  Future<Either<Failure,void>>  resetPassword(String password);
  Future<Either<Failure,List<Price>>> getPrices();
  Future<Either<Failure,void>> addPrice(Price price);
  Future<Either<Failure,void>> updatePrice(Price price);
  Future<Either<Failure,void>> deletePrice(Price price);
  Future<Either<Failure,Company>> getProfile();
  Future<Either<Failure,void>> addDriver(Driver driver,String password);
  Future<Either<Failure,void>> editDriver(Driver driver);
  Future<Either<Failure,void>> deleteDriver(Driver driver);
  Future<Either<Failure,List<Driver>>> getDrivers();
  Future<Either<Failure,void>> addRate(Driver driver);
  Future<Either<Failure,void>> addTrip(Trip trip);
  Future<Either<Failure,void>> updateTrip(Trip trip);
  Future<Either<Failure,void>> deleteTrip(Trip trip);
  Future<Either<Failure,List<Trip>>> getTrips();
  Stream<List<ChatModel>> getChats ();
  Stream<List<MessageModel>> getMessages (String userId);
  Future<Either<Failure,void>> sendMessage (String userId,MessageModel messageModel);
  Future<Either<Failure,List<UserModel>>> getUsers();
  Future<Either<Failure,List<Request>>> getRequests();
  Future<Either<Failure,void>> updateRequest(Request request);
  Future<Either<Failure,UserModel >> getUser(String userId);
}



class CompanyRemoteDataSourceImpl implements CompanyRemoteDataSource {
  ApiCompanyClient apiClient;
  NetworkInfo networkInfo;

  CompanyRemoteDataSourceImpl(this.apiClient, this.networkInfo);

  @override
  Future<Either<Failure, bool>> login(String email, String password) async{
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.Login(email, password);
        return Right(response);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return  Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }
  }

  @override
  Future<Either<Failure, void>> register(Company company, String password) async{
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.Register(company, password);
        return Right(response);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
       return Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }
  }

  @override
  Future<Either<Failure, Company>> getProfile()async {
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.getProfile();
        return Right(response);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
       return Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }
  }

  @override
  Future<Either<Failure, void>> updateProfile(Company company) async{
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.updateProfile(company);
        return Right(response);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    }  else {
       return Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(String password)async {
   if(await networkInfo.isConnected())
     {
       try{
         var response = await apiClient.resetPassword(password);
         return Right(response) ;
       } catch(e){
         return Left(ErrorHandler.handle(e).failure);
       }
     } else {
     return Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);

   }
  }

  @override
  Future<Either<Failure, void>> addPrice(Price price) async{
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.addPrice(price);
        return Right(response);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
       return Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }
  }

  @override
  Future<Either<Failure, void>> deletePrice(Price price) async{
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.deletePrice(price);
        return Right(response);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
       return Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }
  }

  @override
  Future<Either<Failure, List<Price>>> getPrices() async{
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.getPrices();
        return Right(response);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
       return Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }
  }

  @override
  Future<Either<Failure, void>> updatePrice(Price price) async{
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.updatePrice(price);
        return Right(response);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
       return Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }
  }

  @override
  Future<Either<Failure, void>> addDriver(Driver driver, String password) async{
     if(await networkInfo.isConnected()){
       try{
         var response = await apiClient.addDriver(driver, password);
         return Right(response);
       } catch(e){
         return Left(ErrorHandler.handle(e).failure);
       }
     } else {
       return Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
     }
  }

  @override
  Future<Either<Failure, void>> deleteDriver(Driver driver) async{
     if(await networkInfo.isConnected()){
       try{
         var response = await apiClient.deleteDriver(driver);
         return Right(response);
       } catch(e){
         return Left(ErrorHandler.handle(e).failure);
       }
     } else {
       return Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
     }
  }

  @override
  Future<Either<Failure, void>> editDriver(Driver driver) async{
     if(await networkInfo.isConnected()){
       try{
         var response = await apiClient.updateDriver(driver);
         return Right(response);
       } catch(e){
         return Left(ErrorHandler.handle(e).failure);
       }
     } else {
       return Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
     }
  }

  @override
  Future<Either<Failure, List<Driver>>> getDrivers() async{
      if(await networkInfo.isConnected()){
        try{
          var response = await apiClient.getDrivers();
          return Right(response);
        } catch(e){
          return Left(ErrorHandler.handle(e).failure);
        }
      } else {
        return Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
      }
  }

  @override
  Future<Either<Failure, void>> addRate(Driver driver)async {
     if(await networkInfo.isConnected()){
       try{
         var response = await apiClient.addRate(driver);
         return Right(response);
       } catch(e){
         return Left(ErrorHandler.handle(e).failure);
       }
     } else {
       return Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
     }
  }



  @override
  Future<Either<Failure, void>> addTrip(Trip trip) async{
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.addTrip(trip);
        return Right(response);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }

  }

  @override
  Future<Either<Failure, void>> deleteTrip(Trip trip) async{
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.deleteTrip(trip);
        return Right(response);

      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }
  }

  @override
  Future<Either<Failure, List<Trip>>> getTrips() async{
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.getTrips();
        return Right(response);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }
  }

  @override
  Future<Either<Failure, void>> updateTrip(Trip trip) async{
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.updateTrip(trip);
        return Right(response);
      }   catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }
  }

  @override
  Stream<List<ChatModel>> getChats() async*{
    if (await networkInfo.isConnected()) {
      try {
        var response = await apiClient.getChats();
        await for (var event in response) {
          yield event;
        }
      } catch (e) {
        print(e);
      }
    } else {
      print('NO INTERNET CONNECTION');
    }
  }

  @override
  Stream<List<MessageModel>> getMessages(String userId)  async*{
    if (await networkInfo.isConnected()) {
      try {
        var response = await apiClient.getMessages(userId);
        await for (var event in response) {
          yield event;
        }
      } catch (e) {
        print(e);
      }
    } else {
      print('NO INTERNET CONNECTION');
    }
  }

  @override
  Future<Either<Failure, void>> sendMessage(String userId, MessageModel messageModel) async{
     if(await networkInfo.isConnected()){
       try{
         var response = await  apiClient.sendMessage(messageModel, userId);
         return Right(response);
       } catch(e){
         return Left(ErrorHandler.handle(e).failure);
       }
     } else {
       return Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
     }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getUsers()async {
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.getUsers();
        return Right(response);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }
  }

  @override
  Future<Either<Failure, List<Request>>> getRequests()async {
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.getRequests();
        return Right(response);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
      } else {
        return Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
      }
    }

  @override
  Future<Either<Failure, UserModel>> getUser(String userId)async {
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.getUser(userId);
        return Right(response);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }
  }

  @override
  Future<Either<Failure, void>> updateRequest(Request request)async {
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.updateRequest(request);
        return Right(response);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }
  }

}