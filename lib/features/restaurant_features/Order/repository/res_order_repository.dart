import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';
import 'package:foodigo/features/restaurant_features/Order/model/res_order_model.dart';

import '../remote/res_order_remote_data_source.dart';

abstract class ResOrderRepository {
  Future<Either<Failure, List<ResOrderModel>>> getAllOrder(String token);

  Future<Either<Failure, ResOrderModel>> getOrderDetails(
      String token, String orderId);
}

class ResOrderRepositoryImpl implements ResOrderRepository {
  final ResOrderRemoteDataSource remoteDataSource;

  const ResOrderRepositoryImpl({required this.remoteDataSource});

  ///Get All Order
  @override
  Future<Either<Failure, List<ResOrderModel>>> getAllOrder(String token) async {
    try {
      final result = await remoteDataSource.getAllOrder(token);
      final allOrders = (result['data']['order_list'] as List)
          .map((x) => ResOrderModel.fromMap(x))
          .toList();
      return Right(allOrders);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  /// Get Order Details
  @override
  Future<Either<Failure, ResOrderModel>> getOrderDetails(
      String token, String orderId) async {
    try {
      final result = await remoteDataSource.getOrderDetails(token, orderId);
      final order = ResOrderModel.fromMap(result['data']['order']);
      return Right(order);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
