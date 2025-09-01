import 'package:dartz/dartz.dart';
import 'package:foodigo/features/add_to_cart/model/add_cart_response_model.dart';
import 'package:foodigo/features/checkout/model/checkout_response_model.dart';
import 'package:foodigo/features/checkout/model/checkout_state_model.dart';

import '../../../data/errors/exception.dart';
import '../../../data/errors/failure.dart';
import '../remote/checkout_remote_data_source.dart';

abstract class CheckoutRepository {
  Future<Either<dynamic, CheckoutResponseModel>> checkOut(
      CheckoutStateModel body, String token);
}

class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutRemoteDataSource remoteDataSource;

  const CheckoutRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<dynamic, CheckoutResponseModel>> checkOut(
      CheckoutStateModel body, String token) async {
    try {
      final result = await remoteDataSource.checkOut(body, token);
      final response = CheckoutResponseModel.fromMap(result);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }
}
