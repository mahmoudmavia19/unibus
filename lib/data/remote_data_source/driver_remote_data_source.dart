
import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:unibus/core/errors/failure.dart';
import 'package:unibus/presentation/comapny/travels_management/model/trip.dart';

import '../../core/errors/error_handler.dart';
import '../../core/network/network_info.dart';
import '../apiClient/api_driver_client.dart';
import '../models/notification.dart';

abstract class DriverRemoteDataSource {
  Future<Either<Failure,bool>> login(String email, String password);
  Future<Either<Failure,List<Trip>>> getTrips();
  Future<Either<Failure, void>> shareMyLocation(LatLng location);
  Future<Either<Failure, void>> sendNotification(Notification notification);
  Future<Either<Failure, void>> currentTrip(Trip trip);
  Future<Either<Failure, void>> deleteCurrentTrip(Trip trip);

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
  Future<Either<Failure, void>> shareMyLocation(LatLng location) async{
    if(await networkInfo.isConnected()){
      try{
        var result = await apiClient.shareMyLocation(location);
        return Right(result);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> sendNotification(Notification notification) async{
    if(await networkInfo.isConnected()){
      try{
        var result = await apiClient.sendNotification(notification);
        return Right(result);
      } catch(e){
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> currentTrip(Trip trip) async{
    if(await networkInfo.isConnected()){
      try{
        var result = await apiClient.startCurrentTrip(trip);
        return Right(result);
      } catch (e){
        return Left(ErrorHandler.handle(e).failure);
      }
    }  else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteCurrentTrip(Trip trip) async{
    if(await networkInfo.isConnected()){
      try{
        var result = await apiClient.endCurrentTrip(trip);
        return Right(result);
      } catch (e){
        return Left(ErrorHandler.handle(e).failure);
      }
    }  else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}