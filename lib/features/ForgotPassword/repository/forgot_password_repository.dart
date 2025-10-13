import 'package:dartz/dartz.dart';
import 'package:foodigo/features/ForgotPassword/cubit/forgot_password_state_model.dart';
import 'package:foodigo/features/ForgotPassword/remote/forgot_password_remote_data_source.dart';

import '../../../data/errors/exception.dart';
import '../../../data/errors/failure.dart';

abstract class ForgotPasswordRepository {
  Future<Either<dynamic, String>> forgotPassword(Map<String, dynamic> body);

  Future<Either<dynamic, String>> resetPassword(
    ForgotPasswordStateModel body,
  );

  Future<Either<dynamic, String>> verifyForgotOtp(
    ForgotPasswordStateModel body,
    String email,
  );

  Future<Either<dynamic, String>> verifyForgotPassOtp(
    ForgotPasswordStateModel body,
  );
}

class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  final ForgotPasswordRemoteDataSource remoteDataSource;

  const ForgotPasswordRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<dynamic, String>> forgotPassword(
    Map<String, dynamic> body,
  ) async {
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
    ForgotPasswordStateModel body,
  ) async {
    try {
      final result = await remoteDataSource.resetPassword(body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<dynamic, String>> verifyForgotOtp(
    ForgotPasswordStateModel body,
    String email,
  ) async {
    try {
      final result = await remoteDataSource.forgotOtpVerify(body, email);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<dynamic, String>> verifyForgotPassOtp(
    ForgotPasswordStateModel body
  ) async {
    try {
      final result = await remoteDataSource.forgotPassOtpVerify(body);
      return Right(result['message']);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }
}
