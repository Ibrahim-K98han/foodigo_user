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

  Future<Either<dynamic, StoreProductResponseModel>> updateStoreProduct(
      StoreProductStateModel body, Uri uri, String token);

  Future<Either<dynamic, StoreProductResponseModel>> getEditProduct(
      String token, String id, Uri url);

  Future<Either<Failure, StoreProductResponseModel>> deleteStoreProduct(
      String token, String id);
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
      final result = await remoteDataSource.storeProduct(body, uri, token);
      final response = StoreProductResponseModel.fromMap(result);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<dynamic, StoreProductResponseModel>> getEditProduct(
      String token, String id, Uri url) async {
    try {
      final result = await remoteDataSource.getEditProduct(token, id, url);
      final response =
          StoreProductResponseModel.fromMap(result['data']['product']);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  ///Delete Store Product
  @override
  Future<Either<Failure, StoreProductResponseModel>> deleteStoreProduct(
      String token, String id) async {
    try {
      final result = await remoteDataSource.deleteStoreProduct(token, id);
      final data = StoreProductResponseModel.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  /// -------- UPDATE PRODUCT ----------
  @override
  Future<Either<dynamic, StoreProductResponseModel>> updateStoreProduct(
      StoreProductStateModel body, Uri uri, String token) async {
    try {
      final result =
      await remoteDataSource.updateStoreProduct(body, uri, token);
      final response = StoreProductResponseModel.fromMap(result);
      print('product Name: ${response.name}');
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(ServerFailure(e.toString(), 500));
    }
  }
}
