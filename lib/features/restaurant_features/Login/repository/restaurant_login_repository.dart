import 'package:dartz/dartz.dart';
import 'package:foodigo/features/Login/model/login_state_model.dart';
import 'package:foodigo/features/Login/model/user_response_model.dart';
import 'package:foodigo/features/Login/remote/login_remote_data.dart';
import 'package:foodigo/features/restaurant_features/Login/model/restaurant_login_response_model.dart';

import '../../../../data/errors/exception.dart';
import '../../../../data/errors/failure.dart';
import '../../../../data/local_data_source.dart';
import '../model/restaurant_login_state_model.dart';
import '../remote/restaurant_login_remote_data.dart';

abstract class RestaurantLoginRepository {
  Future<Either<dynamic, RestaurantLoginResponse>> restaurantLogin(
      RestaurantLoginStateModel body);

Future<Either<Failure, String>> restaurantLogout(Uri uri, String token);

Either<Failure, RestaurantLoginResponse> getExistingRestaurantInfo();

  ///registration related class
// Future<Either<dynamic, String>> signUp(RegisterStateModel body);

// Future<Either<dynamic, String>> verifyRegOtp(RegisterStateModel body);
//
// Future<Either<Failure, GetLocationDataModel>> getLocationData(SignUpStateModel body);
//
//

// Future<Either<dynamic, String>> forgotPassword(PasswordStateModel body);
//
// Future<Either<dynamic, String>> forgotOtpVerify(PasswordStateModel body);
//
// Future<Either<dynamic, String>> setResetPassword(PasswordStateModel body);
//
// Future<Either<dynamic, String>> updatePassword(PasswordStateModel body, Uri url);
}

class RestaurantLoginRepositoryImpl implements RestaurantLoginRepository {
  final RestaurantLoginRemoteData remoteDataSources;
  final LocalDataSources localDataSources;

  RestaurantLoginRepositoryImpl(
      {required this.remoteDataSources, required this.localDataSources});

  @override
  Future<Either<dynamic, RestaurantLoginResponse>> restaurantLogin(
      RestaurantLoginStateModel body) async {
    try {
      final result = await remoteDataSources.restaurantLogin(body);
      final response = RestaurantLoginResponse.fromMap(result['data']);
      localDataSources.cacheRestaurantResponse(response);

      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Either<Failure, RestaurantLoginResponse> getExistingRestaurantInfo() {
    try {
      final result = localDataSources.getExistingRestaurantInfo();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

@override
Future<Either<Failure, String>> restaurantLogout(Uri uri, String token) async {
  try {
    final logout = await remoteDataSources.restaurantLogout(uri, token);
    localDataSources.clearUserResponse();
    return Right(logout['message']);
  } on ServerException catch (e) {
    return Left(ServerFailure(e.message, e.statusCode));
  }
}

}
