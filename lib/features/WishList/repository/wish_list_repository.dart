import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';
import 'package:foodigo/features/WishList/model/wish_list_model.dart';

import '../remote/wish_list_remote_data_source.dart';

abstract class WishListRepository {
  Future<Either<Failure, WishListModel>> getWishList(String token);

  Future<Either<Failure, WishListModel>> addToWishList(
      String token, int productId);

  Future<Either<Failure, WishListModel>> removeFromWishList(
      String token, int wishListId);
}

class WishListRepositoryImpl implements WishListRepository {
  final WishListRemoteDataSource remoteDataSource;

  const WishListRepositoryImpl({required this.remoteDataSource});

  ///show wishlist
  @override
  Future<Either<Failure, WishListModel>> getWishList(String token) async {
    try {
      final result = await remoteDataSource.getWishList(token);
      final wishList = WishListModel.fromMap(result);
      return Right(wishList);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  ///Add Wishlist
  @override
  Future<Either<Failure, WishListModel>> addToWishList(
      String token, int productId) async {
    try {
      final result = await remoteDataSource.addToWishList(token, productId);
      final wishList = WishListModel.fromMap(result);
      return Right(wishList);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  ///remove wishlist
  @override
  Future<Either<Failure, WishListModel>> removeFromWishList(
      String token, int wishListId) async {
    try {
      final result =
          await remoteDataSource.removeFromWishList(token, wishListId);
      final wishList = WishListModel.fromMap(result);
      return Right(wishList);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
