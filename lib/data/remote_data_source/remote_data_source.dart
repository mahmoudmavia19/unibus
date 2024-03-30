import 'package:dartz/dartz.dart';
import 'package:unibus/core/app_export.dart';
import 'package:unibus/core/errors/error_handler.dart';
 import 'package:unibus/data/apiClient/api_client.dart';
import 'package:unibus/presentation/admin/companies_management/model/company_model.dart';
import 'package:unibus/presentation/admin/users_manage/model/user_model.dart';
import 'package:unibus/presentation/comapny/chat_center/model/message_model.dart';
import 'package:unibus/presentation/comapny/drivers_management/model/driver.dart';
import 'package:unibus/presentation/comapny/price_management/model/price.dart';
import 'package:unibus/presentation/comapny/travels_management/model/trip.dart';
import 'package:unibus/presentation/user/payment_screen/request/request.dart';

import '../../core/errors/failure.dart';

abstract class RemoteDataSource {
  Future<Either<Failure,bool>> login(String email, String password);
  Future<Either<Failure,void>> register(UserModel userModel, String password);
  Future<Either<Failure,List<Company>>> getCompany();
  //get stream messages
  Stream<List<MessageModel>> getMessages (String companyID);
  Future<Either<Failure, void>> sendMessage (String companyID,MessageModel messageModel);
  Future<Either<Failure,UserModel>> getProfile ();
  Future<Either<Failure, void>> updateProfile (UserModel user);
  Future<Either<Failure, List<Trip>>> getTrips(String companyID,String districtId);
  Future<Either<Failure,Driver>> getDriver(String driverId) ;
  Future<Either<Failure,void>> subscribeToTrip(Request request);
  Future<Either<Failure,List<Price>>> getPrices(String companyId);
   }
class RemoteDateSourceImpl implements RemoteDataSource {
  ApiClient apiClient ;
  NetworkInfo networkInfo;

  RemoteDateSourceImpl(this.apiClient, this.networkInfo);

  @override
  Future<Either<Failure, bool>> login(String email, String password) async{
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.Login(email, password);
        return Right(response);
      }catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return  Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }
  }

  @override
  Future<Either<Failure, void>> register(UserModel userModel, String password) async{
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.Register(userModel, password);
        return Right(response);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return  Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }
  }

  @override
  Future<Either<Failure, List<Company>>> getCompany()async {
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.getCompany();
        return Right(response);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return  Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }
  }

  @override
  Stream<List<MessageModel>> getMessages(String companyID) async* {
    if (await networkInfo.isConnected()) {
      try {
        var response = await apiClient.getMessages(companyID);
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
  Future<Either<Failure, void>> sendMessage(String companyID, MessageModel messageModel) async{
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.sendMessage(companyID, messageModel);
        return Right(response);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }
  }

  @override
  Future<Either<Failure, UserModel>> getProfile() async{
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
  Future<Either<Failure, void>> updateProfile(UserModel user) async{
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.updateProfile(user);
        return Right(response);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }
  }

  @override
  Future<Either<Failure, List<Trip>>> getTrips(String companyID,String districtId) async{
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.getTrips(companyID, districtId);
        return Right(response);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }
  }

  @override
  Future<Either<Failure, Driver>> getDriver(String driverId) async{
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.getDriver(driverId);
        return Right(response);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }
  }

  @override
  Future<Either<Failure, void>> subscribeToTrip(Request request) async{
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.subscribe(request) ;
        return Right(response);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }
  }

  @override
  Future<Either<Failure, List<Price>>> getPrices(String companyId) async{
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.getPrice(companyId);
        return Right(response);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }
  }

}