import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';

import '../model/order_status_model.dart';
import '../remote/order_status_remote_data_source.dart';

abstract class OrderStatusRepository {
  Future<Either<Failure, OrderStatusModel>> chageOrderStatus(
    String token,
    String orderId,
    String statusId,
  );
}

class OrderStatusRepositoryImpl implements OrderStatusRepository {
  final OrderStatusRemoteDataSource remoteDataSource;

  const OrderStatusRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, OrderStatusModel>> chageOrderStatus(
    String token,
    String orderId,
    String statusId,
  ) async {
    try {
      final result =
          await remoteDataSource.changeOrderStatus(token, orderId, statusId);

      print('Repository Result: $result');

      final order = OrderStatusModel.fromMap(result['data']);

      return Right(order);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
