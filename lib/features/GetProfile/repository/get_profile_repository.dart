import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';
import 'package:foodigo/features/GetProfile/model/profile_state_model.dart';
import 'package:foodigo/features/Login/model/user_response_model.dart';

import '../remote/get_profile_remote_data_source.dart';

abstract class GetProfileRepository {
  Future<Either<Failure, User>> getProfileData(String token);

  Future<Either<Failure, User>> updateProfile(
    ProfileStateModel body,
    Uri uri,
    String token,
  );
}

class GetProfileRepositoryImpl implements GetProfileRepository {
  final GetProfileRemoteDataSource remoteDataSource;

  const GetProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> getProfileData(String token) async {
    try {
      final result = await remoteDataSource.getProfileData(token);
      final data = User.fromMap(result['data']['user']);
      // final res = result['data'];
      // final data =
      //     List<Restaurants>.from(res.map((e) => Restaurants.fromMap(e)))
      //         .toList();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  //update profile
  @override
  Future<Either<Failure, User>> updateProfile(
    ProfileStateModel body,
    Uri uri,
    String token,
  ) async {
    try {
      final result = await remoteDataSource.updateProfile(body, uri, token);
      final response = User.fromMap(result);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(ServerFailure(e.toString(), 500));
    }
  }
}
