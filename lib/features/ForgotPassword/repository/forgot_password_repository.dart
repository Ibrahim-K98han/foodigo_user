import 'package:dartz/dartz.dart';
import 'package:foodigo/features/ForgotPassword/cubit/forgot_password_state_model.dart';
import 'package:foodigo/features/ForgotPassword/remote/forgot_password_remote_data_source.dart';

import '../../../data/errors/exception.dart';
import '../../../data/errors/failure.dart';

abstract class ForgotPasswordRepository {
  Future<Either<dynamic, String>> forgotPassword(Map<String, dynamic> body);

  Future<Either<dynamic, String>> resetPassword(
      ForgotPasswordStateModel body, String email, String otp);
  Future<Either<dynamic, String>> verifyRegOtp(
      ForgotPasswordStateModel body, String email);
}

class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  final ForgotPasswordRemoteDataSource remoteDataSource;

  const ForgotPasswordRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<dynamic, String>> forgotPassword(
      Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.forgotPassword(body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<dynamic, String>> resetPassword(
      ForgotPasswordStateModel body, String email, String otp) async {
    try {
      final result = await remoteDataSource.resetPassword(body, email, otp);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<dynamic, String>> verifyRegOtp(
      ForgotPasswordStateModel body, String email) async {
    try {
      final result = await remoteDataSource.otpVerify(body, email);
      return Right(result['message']);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }
}
