import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';
import 'package:foodigo/features/Splash/model/splash_response_model.dart';
import '../remote/splash_remote_data_source.dart';

abstract class SplashRepository {
  Future<Either<Failure, SplashResponseModel>> getSplash();
}

class SplashRepositoryImpl implements SplashRepository {
  final SplashRemoteDataSource remoteDataSource;

  const SplashRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, SplashResponseModel>> getSplash() async {
    try {
      final result = await remoteDataSource.getSplash();
      final review = SplashResponseModel.fromMap(result['data']);
      return Right(review);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
