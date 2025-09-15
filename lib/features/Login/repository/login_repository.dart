import 'package:dartz/dartz.dart';
import 'package:foodigo/features/Login/model/user_response_model.dart';
import 'package:foodigo/features/Login/remote/login_remote_data.dart';

import '../../../data/errors/exception.dart';
import '../../../data/errors/failure.dart';
import '../../../data/local_data_source.dart';
import '../model/login_state_model.dart';

abstract class LoginRepository {
  Future<Either<dynamic, UserResponseModel>> login(LoginStateModel body);

  Future<Either<Failure, String>> logout(Uri uri, String token);

//
  Either<Failure, UserResponseModel> getExistingUserInfo();

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

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSources;
  final LocalDataSources localDataSources;

  LoginRepositoryImpl(
      {required this.remoteDataSources, required this.localDataSources});

  @override
  Future<Either<dynamic, UserResponseModel>> login(LoginStateModel body) async {
    try {
      final result = await remoteDataSources.login(body);
      final response = UserResponseModel.fromMap(result['data']);
      localDataSources.cacheUserResponse(response);

      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

//
  @override
  Either<Failure, UserResponseModel> getExistingUserInfo() {
    try {
      final result = localDataSources.getExistingUserInfo();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> logout(Uri uri, String token) async {
    try {
      final logout = await remoteDataSources.logout(uri, token);
      localDataSources.clearUserResponse();
      return Right(logout['message']);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
//
// @override
// Future<Either<dynamic, String>> signUp(RegisterStateModel body) async {
//   try {
//     final result = await remoteDataSources.register(body);
//     return Right(result['message']);
//   } on InvalidAuthData catch (e) {
//     return Left(InvalidAuthData(e.errors));
//   } on ServerException catch (e) {
//     return Left(ServerFailure(e.message, e.statusCode));
//   }
// }
//
// @override
// Future<Either<dynamic, String>> verifyRegOtp(RegisterStateModel body) async {
//   try {
//     final result = await remoteDataSources.otpVerify(body);
//     return Right(result['message']);
//   } on ServerException catch (e) {
//     return Left(ServerFailure(e.message, e.statusCode));
//   } on InvalidAuthData catch (e) {
//     return Left(InvalidAuthData(e.errors));
//   }
// }

// @override
// Future<Either<Failure, GetLocationDataModel>> getLocationData(SignUpStateModel body) async {
//   try {
//     final result = await remoteDataSources.getLocationData(body);
//     final data = GetLocationDataModel.fromMap(result);
//     return Right(data);
//   } on ServerException catch (e) {
//     return Left(ServerFailure(e.message, e.statusCode));
//   }
// }
//
//   @override
//   Future<Either<dynamic, String>> forgotPassword(
//       PasswordStateModel body) async {
//     try {
//       final result = await remoteDataSources.forgotPassword(body);
//       return Right(result['message']);
//     } on ServerException catch (e) {
//       return Left(ServerFailure(e.message, e.statusCode));
//     } on InvalidAuthData catch (e) {
//       return Left(InvalidAuthData(e.errors));
//     }
//   }
//
//   @override
//   Future<Either<dynamic, String>> forgotOtpVerify(
//       PasswordStateModel body) async {
//     try {
//       final result = await remoteDataSources.forgotOtpVerify(body);
//       return Right(result['message']);
//     } on ServerException catch (e) {
//       return Left(ServerFailure(e.message, e.statusCode));
//     } on InvalidAuthData catch (e) {
//       return Left(InvalidAuthData(e.errors));
//     }
//   }
//
//   @override
//   Future<Either<dynamic, String>> setResetPassword(
//       PasswordStateModel body) async {
//     try {
//       final result = await remoteDataSources.setResetPassword(body);
//       return Right(result['message']);
//     } on ServerException catch (e) {
//       return Left(ServerFailure(e.message, e.statusCode));
//     } on InvalidAuthData catch (e) {
//       return Left(InvalidAuthData(e.errors));
//     }
//   }
//
//   @override
//   Future<Either<dynamic, String>> updatePassword(
//       PasswordStateModel body, Uri url) async {
//     try {
//       final result = await remoteDataSources.updatePassword(body, url);
//       return Right(result['message']);
//     } on ServerException catch (e) {
//       return Left(ServerFailure(e.message, e.statusCode));
//     } on InvalidAuthData catch (e) {
//       return Left(InvalidAuthData(e.errors));
//     }
//   }
}
