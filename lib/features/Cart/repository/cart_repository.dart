import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';
import 'package:foodigo/features/Cart/model/cart_model.dart';

import '../remote/cart_remote_data_source.dart';

abstract class CartRepository {
  Future<Either<Failure, CartModel>> getCartData(String token);

  Future<Either<Failure, CartModel>> deleteProduct(String token, String id);

  Future<Either<Failure, CartModel>> incrementProduct(
      CartModel body, String token, String id);

  Future<Either<Failure, CartModel>> decrementProduct(
      CartModel body, String token, String id);

  Future<Either<Failure, CartModel>> clearCart(String token);
}

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  const CartRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, CartModel>> getCartData(String token) async {
    try {
      final result = await remoteDataSource.getCart(token);
      final data = CartModel.fromMap(result['data']);
      // final res = result['data']['restaurants'] as List;
      // final data =
      //     List<Restaurants>.from(res.map((e) => Restaurants.fromMap(e)))
      //         .toList();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  ///Delete Product
  @override
  Future<Either<Failure, CartModel>> deleteProduct(
      String token, String id) async {
    try {
      final result = await remoteDataSource.deleteProduct(token, id);
      final data = CartModel.fromMap(result['data']);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  ///Product Decrement
  @override
  Future<Either<Failure, CartModel>> decrementProduct(
      CartModel body, String token, String id) async {
    try {
      final result = await remoteDataSource.decrementProduct(body, token, id);
      final data = CartModel.fromMap(result['data']);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  ///Product Increment
  @override
  Future<Either<Failure, CartModel>> incrementProduct(
      CartModel body, String token, String id) async {
    try {
      final result = await remoteDataSource.incrementProduct(body, token, id);
      final data = CartModel.fromMap(result['data']);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, CartModel>> clearCart(String token) async {
    try {
      final result = await remoteDataSource.clearCart(token);

      final dataMap = result['data'] is Map<String, dynamic>
          ? result['data']
          : {'cart_items': []};

      final data = CartModel.fromMap(dataMap);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
