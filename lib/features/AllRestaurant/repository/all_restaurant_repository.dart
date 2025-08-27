import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';
import 'package:foodigo/features/HomeData/restaurant_model.dart';

import '../remote/all_restaurant_remote_data_source.dart';

abstract class AllRestaurantRepository {
  Future<Either<Failure, List<Restaurants>>> getAllRestaurantData();
}

class AllRestaurantRepositoryImpl implements AllRestaurantRepository {
  final AllRestaurantRemoteDataSource remoteDataSource;

  const AllRestaurantRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Restaurants>>> getAllRestaurantData() async {
    try {
      final result = await remoteDataSource.getAllRestaurant();
      // final data = Restaurants.fromMap(result);
      final res = result['data']['restaurants'] as List;
      final data =
          List<Restaurants>.from(res.map((e) => Restaurants.fromMap(e)))
              .toList();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
