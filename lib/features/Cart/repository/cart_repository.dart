import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';
import 'package:foodigo/features/Cart/model/cart_model.dart';

import '../remote/cart_remote_data_source.dart';

abstract class CartRepository {
  Future<Either<Failure, CartModel>> getCartData();
}

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  const CartRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, CartModel>> getCartData() async {
    try {
      final result = await remoteDataSource.getCart();
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
}
