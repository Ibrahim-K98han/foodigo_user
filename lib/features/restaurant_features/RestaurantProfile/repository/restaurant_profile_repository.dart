import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';

import '../model/restaurant_profile_model.dart';
import '../remote/restaurant_profile_remote_data_source.dart';

abstract class RestaurantProfileRepository {
  Future<Either<Failure, RestaurantProfileModel>> getRestaurantProfile(String token);

}

class RestaurantProfileRepositoryImpl implements RestaurantProfileRepository {
  final RestaurantProfileRemoteDataSource remoteDataSource;

  const RestaurantProfileRepositoryImpl({required this.remoteDataSource});

  ///Get Restaurant Profile
  @override
  Future<Either<Failure, RestaurantProfileModel>> getRestaurantProfile(String token) async {
    try {
      final result = await remoteDataSource.getRestaurantProfile(token);
      final review = RestaurantProfileModel.fromMap(result['data']['restaurant']);
      return Right(review);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
