
import 'package:dartz/dartz.dart';
import 'package:unibus/core/errors/error_handler.dart';
import 'package:unibus/core/errors/failure.dart';
import 'package:unibus/presentation/admin/companies_management/model/company_model.dart';

import '../../core/network/network_info.dart';
import '../apiClient/api_company_client.dart';

abstract class CompanyRemoteDataSource{
  Future<Either<Failure,bool>> login(String email, String password);
  Future<Either<Failure,void>> register(Company userModel, String password);
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

}