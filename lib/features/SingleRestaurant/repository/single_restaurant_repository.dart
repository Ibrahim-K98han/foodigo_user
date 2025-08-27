import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';
import 'package:foodigo/features/SingleRestaurant/model/single_restaurant_model.dart';

import '../remote/single_restaurant_remote_data_source.dart';

abstract class SingleRestaurantRepository {
  Future<Either<Failure, RestaurantDetailsModel>> getSingleRestaurantData(
      String slug);
}

class SingleRestaurantRepositoryImpl implements SingleRestaurantRepository {
  final SingleRestaurantRemoteDataSource remoteDataSource;

  const SingleRestaurantRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, RestaurantDetailsModel>> getSingleRestaurantData(
      String slug) async {
    try {
      final result = await remoteDataSource.getSingleRestaurant(slug);
      final data = RestaurantDetailsModel.fromMap(result['data']);
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
