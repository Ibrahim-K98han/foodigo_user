import 'package:dartz/dartz.dart';
import 'package:foodigo/features/ForgotPassword/cubit/forgot_password_state_model.dart';
import 'package:foodigo/features/ForgotPassword/remote/forgot_password_remote_data_source.dart';

import '../../../data/errors/exception.dart';
import '../../../data/errors/failure.dart';
import '../cubit/forgot_password_verify_state_model.dart';
import '../remote/forgot_password_verify_remote_data_source.dart';

abstract class ForgotPasswordVerifyRepository {


  Future<Either<dynamic, String>> verifyForgotPassOtp(
      ForgotPasswordVerifyStateModel body,
  );
}

class ForgotPasswordVerifyRepositoryImpl implements ForgotPasswordVerifyRepository {
  final ForgotPasswordVerifyRemoteDataSource remoteDataSource;

  const ForgotPasswordVerifyRepositoryImpl({required this.remoteDataSource});


  @override
  Future<Either<dynamic, String>> verifyForgotPassOtp(
      ForgotPasswordVerifyStateModel body
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
