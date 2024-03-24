import 'package:dartz/dartz.dart';
import 'package:unibus/core/errors/failure.dart';

import '../../core/errors/error_handler.dart';
import '../../core/network/network_info.dart';
import '../apiClient/api_driver_client.dart';

abstract class DriverRemoteDataSource {
  Future<Either<Failure,bool>> login(String email, String password);
}
class DriverRemoteDataSourceImpl implements DriverRemoteDataSource {
  ApiDriverClient apiClient;
  NetworkInfo networkInfo;

  DriverRemoteDataSourceImpl(this.apiClient, this.networkInfo);

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
}