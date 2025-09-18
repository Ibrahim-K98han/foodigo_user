import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';
import 'package:foodigo/features/add_to_cart/model/add_cart_response_model.dart';
import 'package:foodigo/features/add_to_cart/model/add_cart_state_model.dart';
import 'package:foodigo/features/restaurant_features/StoreProduct/model/store_product_response_model.dart';
import 'package:foodigo/features/restaurant_features/StoreProduct/model/store_product_state_model.dart';

import '../remote/store_product_remote_data_source.dart';

abstract class StoreProductRepository {
  Future<Either<dynamic, StoreProductResponseModel>> storeProduct(
      StoreProductStateModel body, Uri uri, String token);

  Future<Either<dynamic, AddCartResponseModel>> updateCart(
      AddCartStateModel body, String token, int id);
}

class StoreProductRepositoryImpl implements StoreProductRepository {
  final StoreProductRemoteDataSource remoteDataSource;

  const StoreProductRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<dynamic, StoreProductResponseModel>> storeProduct(
      StoreProductStateModel body, uri, String token) async {
    try {
      final result = await remoteDataSource.storeProduct(body,uri, token);
      final response = StoreProductResponseModel.fromMap(result);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<dynamic, AddCartResponseModel>> updateCart(
      AddCartStateModel body, String token, int id) async {
    try {
      final result = await remoteDataSource.updateCart(body, token, id);
      final response = AddCartResponseModel.fromMap(result);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }
}
