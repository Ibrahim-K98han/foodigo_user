import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';
import 'package:foodigo/features/HomeData/home_data_model.dart';

import '../remote/home_data_remote_data_source.dart';

abstract class HomeDataRepository {
  Future<Either<Failure, HomeModel>> getHomeDataData();
}

class HomeDataRepositoryImpl implements HomeDataRepository {
  final HomeDataRemoteDataSource remoteDataSource;

  const HomeDataRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, HomeModel>> getHomeDataData() async {
    try {
      final result = await remoteDataSource.getHomeData();
      final data = HomeModel.fromMap(result['data']);
      print('====================$data');
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
