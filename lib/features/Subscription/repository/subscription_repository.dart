import 'package:dartz/dartz.dart';
import 'package:foodigo/features/Subscription/remote/subscription_remote_data_source.dart';

import '../../../data/errors/exception.dart';
import '../../../data/errors/failure.dart';
import '../model/bank_payment_request_model.dart';
import '../model/bank_payment_response_model.dart';
import '../model/payment_to_map_model.dart';

abstract class SubscriptionRepository {
  Future<Either<Failure, BankPaymentResponseModel>> payWithBank(
      BankPaymentRequestModel body, String token);
  //
  // Future<Either<Failure, StripResponseModel>> payWithStripe(
  //     OrderDataRequest body, String token);
}

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final SubscriptionRemoteDataSource remoteDataSource;

  SubscriptionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, BankPaymentResponseModel>> payWithBank(
      BankPaymentRequestModel body, String token) async {
    try {
      // Call remote data source
      final result = await remoteDataSource.payWithBank(body, token);

      // Parse API response into response model
      final response = BankPaymentResponseModel.fromMap(result);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    } catch (e) {
      return Left(ServerFailure(e.toString(), 500));
    }
  }
  //
  // @override
  // Future<Either<Failure, StripResponseModel>> payWithStripe(
  //     OrderDataRequest body, String token) async {
  //   try {
  //     // Call remote data source
  //     final result = await remoteDataSource.payWithStripe(body, token);
  //
  //     // Parse API response into response model
  //     final response = PaymentResponseModel.fromJson(result);
  //     return Right(response);
  //   } on ServerException catch (e) {
  //     return Left(ServerFailure(e.message, e.statusCode));
  //   } on InvalidAuthData catch (e) {
  //     return Left(InvalidAuthData(e.errors));
  //   } catch (e) {
  //     return Left(ServerFailure(e.toString(), 500));
  //   }
  // }
}
