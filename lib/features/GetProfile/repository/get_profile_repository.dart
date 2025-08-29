import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';
import 'package:foodigo/features/Login/model/user_response_model.dart';

import '../remote/get_profile_remote_data_source.dart';

abstract class GetProfileRepository {
  Future<Either<Failure, User>> getProfileData(String token);
}

class GetProfileRepositoryImpl implements GetProfileRepository {
  final GetProfileRemoteDataSource remoteDataSource;

  const GetProfileRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, User>> getProfileData(String token) async {
    try {
      final result = await remoteDataSource.getProfileData(token);
      final data = User.fromMap(result['data']);
      // final res = result['data'];
      // final data =
      //     List<Restaurants>.from(res.map((e) => Restaurants.fromMap(e)))
      //         .toList();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
