import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';

import '../model/earning_model.dart';
import '../remote/earning_remote_data_source.dart';

abstract class EarningRepository {
  Future<Either<Failure, EarningModel>> getEarning(String token);
}

class EarningRepositoryImpl implements EarningRepository {
  final EarningRemoteDataSource remoteDataSource;

  const EarningRepositoryImpl({required this.remoteDataSource});

  /// Get Earning
  @override
  Future<Either<Failure, EarningModel>> getEarning(String token) async {
    try {
      final result = await remoteDataSource.getEarning(token);
      final earning = EarningModel.fromMap(result['data']);
      return Right(earning);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

}
