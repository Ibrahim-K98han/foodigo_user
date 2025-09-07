import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';

import '../model/payment_method_response_model.dart';
import '../remote/payment_method_remote_data_source.dart';

abstract class PaymentMethodRepository {
  Future<Either<Failure, PaymentMethodResponseModel>> getPaymentMethod(String token);
}

class PaymentMethodRepositoryImpl implements PaymentMethodRepository {
  final PaymentMethodRemoteDataSource remoteDataSource;

  const PaymentMethodRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, PaymentMethodResponseModel>> getPaymentMethod(String token) async {
    try {
      final result = await remoteDataSource.getPaymentMethod(token);
      final data = PaymentMethodResponseModel.fromMap(result['data']);
      // final res = result['data']['restaurants'] as List;
      // final data =
      //     List<Restaurants>.from(res.map((e) => Restaurants.fromMap(e)))
      //         .toList();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
