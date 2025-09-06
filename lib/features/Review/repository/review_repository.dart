import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';
import 'package:foodigo/features/Review/model/review_model.dart';
import 'package:foodigo/features/WishList/model/wish_list_model.dart';

import '../remote/review_remote_data_source.dart';

abstract class ReviewRepository {
  Future<Either<Failure, ReviewModel>> getReview(String token);

// Future<Either<Failure, WishListModel>> addToWishList(
//     String token, int productId);
}

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource remoteDataSource;

  const ReviewRepositoryImpl({required this.remoteDataSource});

  ///show Review
  @override
  Future<Either<Failure, ReviewModel>> getReview(String token) async {
    try {
      final result = await remoteDataSource.getReview(token);
      final review = ReviewModel.fromMap(result);
      return Right(review);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  ///Add Review
// @override
// Future<Either<Failure, WishListModel>> addToWishList(
//     String token, int productId) async {
//   try {
//     final result = await remoteDataSource.addToWishList(token, productId);
//     final wishList = WishListModel.fromMap(result);
//     return Right(wishList);
//   } on ServerException catch (e) {
//     return Left(ServerFailure(e.message, e.statusCode));
//   }
// }
//
}
