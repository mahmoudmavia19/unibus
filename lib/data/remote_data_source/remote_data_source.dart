import 'package:dartz/dartz.dart';
import 'package:unibus/core/app_export.dart';
import 'package:unibus/core/errors/error_handler.dart';
 import 'package:unibus/data/apiClient/api_client.dart';
import 'package:unibus/presentation/admin/users_manage/model/user_model.dart';

import '../../core/errors/failure.dart';

abstract class RemoteDataSource {
  Future<Either<Failure,bool>> login(String email, String password);
  Future<Either<Failure,void>> register(UserModel userModel, String password);
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

}