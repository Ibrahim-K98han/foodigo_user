import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';
import 'package:foodigo/features/Order/model/order_model.dart';

import '../remote/order_remote_data_source.dart';
abstract class OrderRepository {
  Future<Either<Failure, List<OrderModel>>> getOrderData(String token);
}

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  const OrderRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<OrderModel>>> getOrderData(String token) async {
    try {
      final result = await remoteDataSource.getOrderData(token);
      final data = (result['data'] as List)
          .map((e) => OrderModel.fromMap(e as Map<String, dynamic>))
          .toList();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
