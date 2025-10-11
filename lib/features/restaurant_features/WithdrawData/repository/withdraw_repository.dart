import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';
import 'package:foodigo/features/restaurant_features/WithdrawData/model/withdraw_model.dart';

import '../model/withdraw_store_state_model.dart';
import '../remote/withdraw_remote_data_source.dart';

abstract class WithdrawRepository {
  Future<Either<Failure, WithdrawModel>> getWithdrawMethod(String token);
  Future<Either<Failure, NewWithdrawResponse>> addNewWithdraw(
    WithdrawStoreStateModel body,
    String token,
  );
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
  Future<Either<Failure, NewWithdrawResponse>> addNewWithdraw(
    WithdrawStoreStateModel body,
    String token,
  ) async {
    try {
      final result = await remoteDataSource.addNewWithdraw(body, token);

      if (result['data'] is Map<String, dynamic> &&
          result['data']['new_withdraw'] != null) {
        final response = NewWithdrawResponse.fromMap(
          result['data']['new_withdraw'],
        );
        return Right(response);
      } else if (result['data'] is String) {
        // API returned an error message as a string
        return Left(ServerFailure(result['data'], 400));
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
