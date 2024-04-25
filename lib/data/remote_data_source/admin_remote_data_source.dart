import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:unibus/core/app_export.dart';
import 'package:unibus/core/errors/failure.dart';

import '../../core/errors/error_handler.dart';
import '../../presentation/admin/companies_management/model/company_model.dart';
import '../../presentation/admin/users_manage/model/user_model.dart';
import '../apiClient/api_admin_client.dart';
import '../models/admin.dart';

abstract class AdminRemoteDataSource {
  Future<Either<Failure,bool>> login(String email, String password);
  Future<Either<Failure,List<UserModel>>> getUsers();
  Future<Either<Failure,AdminModel>> getProfile();
  Future<Either<Failure,void>> updateProfile(AdminModel admin);
  Future<Either<Failure,List<Company>>> getCompany();
  Future<Either<Failure,void>> blockUser(String userId);
  Future<Either<Failure,void>> unblockUser(String userId);
  Future<Either<Failure,void>> blockCompany(String companyId);
  Future<Either<Failure,void>> unblockCompany(String companyId);
  Future<Either<Failure,void>> resetPassword(String password);
  Future<Either<Failure,void>> forgetPassword(String email);



}

class AdminRemoteDataSourceImpl implements AdminRemoteDataSource {
  ApiAdminClient apiClient;

  NetworkInfo networkInfo;

  AdminRemoteDataSourceImpl(this.apiClient, this.networkInfo);

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
  Future<Either<Failure, void>> blockCompany(String companyId) async{
     if(await networkInfo.isConnected()){
       try{
         var response = await apiClient.blockCompany(companyId);
         return Right(response);
       } catch(e){
         return Left(ErrorHandler.handle(e).failure);
       }
     } else {
       return  Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
     }
  }

  @override
  Future<Either<Failure, void>> blockUser(String userId) async{
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.blockUser(userId);
        return Right(response);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return  Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }
  }

  @override
  Future<Either<Failure, List<Company>>> getCompany() async{
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
  Future<Either<Failure, List<UserModel>>> getUsers() async{
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.getUsers();
        return Right(response);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return  Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }
  }

  @override
  Future<Either<Failure, void>> unblockCompany(String companyId) async{
     if(await networkInfo.isConnected()){
       try{
         var response = await apiClient.unblockCompany(companyId);
         return Right(response);
       } catch(e){
         return Left(ErrorHandler.handle(e).failure);
       }
     } else {
       return  Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
     }
  }

  @override
  Future<Either<Failure, void>> unblockUser(String userId) async{
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.unblockUser(userId);
        return Right(response);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    }  else {
      return  Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }
  }

  @override
  Future<Either<Failure, AdminModel>> getProfile()async{
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.getProfile();
        return Right(response);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return  Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }

  }

  @override
  Future<Either<Failure, void>> updateProfile(AdminModel admin) async{
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.updateProfile(admin);
        return Right(response);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return  Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(String password) async{
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.resetPassword(password);
        return Right(response);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    }  else {
      return  Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }
  }

  @override
  Future<Either<Failure, void>> forgetPassword(String email) async{
    if(await networkInfo.isConnected()){
      try{
        var response = await apiClient.forgetPassword(email);
        return Right(response);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    }  else {
      return  Left(ErrorHandler.handle(DataSource.NO_INTERNET_CONNECTION).failure);
    }
  }



}