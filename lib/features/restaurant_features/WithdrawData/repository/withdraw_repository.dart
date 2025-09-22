import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';
import 'package:foodigo/features/restaurant_features/WithdrawData/model/withdraw_model.dart';
import '../model/withdraw_store_state_model.dart';
import '../remote/withdraw_remote_data_source.dart';

abstract class WithdrawRepository {
  Future<Either<Failure, WithdrawModel>> getWithdrawMethod(String token);
  Future<Either<Failure, WithdrawModel>> addNewWithdraw(
      WithdrawStoreStateModel body, String token);
}

class WithdrawRepositoryImpl implements WithdrawRepository {
  final WithdrawRemoteDataSource remoteDataSource;

  const WithdrawRepositoryImpl({required this.remoteDataSource});

  /// Get Withdraw Method
  @override
  Future<Either<Failure, WithdrawModel>> getWithdrawMethod(String token) async {
    try {
      final result = await remoteDataSource.getWithdrawMethod(token);
      final earning = WithdrawModel.fromMap(result['data']);
      return Right(earning);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  /// Add Withdraw
  @override
  Future<Either<Failure, WithdrawModel>> addNewWithdraw(
      WithdrawStoreStateModel body, String token) async {
    try {
      final result = await remoteDataSource.addNewWithdraw(body, token);

      if (result is Map<String, dynamic> && result['data'] != null) {
        final response = WithdrawModel.fromMap(result['data']);
        return Right(response);
      } else {
        return const Left(ServerFailure('Invalid response format', 500));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }
}
