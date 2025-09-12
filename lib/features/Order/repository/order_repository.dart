import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';
import 'package:foodigo/features/Order/model/order_details_model.dart';
import 'package:foodigo/features/Order/model/order_model.dart';

import '../remote/order_remote_data_source.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<OrderModel>>> getOrderData(String token);

  Future<Either<Failure, OrderDetails>> getOrderDetails(String token, int id);
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

  @override
  Future<Either<Failure, OrderDetails>> getOrderDetails(
      String token, int id) async {
    try {
      final result = await remoteDataSource.getOrderDetails(id, token);

      final data = OrderDetails.fromMap(result['data'] as Map<String, dynamic>);

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
