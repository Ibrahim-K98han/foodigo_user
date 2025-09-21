import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';

import '../model/res_addon_model.dart';
import '../remote/res_addon_remote_data_source.dart';

abstract class ResAddonRepository {
  Future<Either<Failure, ResAddonModel>> getAddonList(String token);
}

class ResAddonRepositoryImpl implements ResAddonRepository {
  final ResAddonRemoteDataSource remoteDataSource;

  const ResAddonRepositoryImpl({required this.remoteDataSource});

  /// Get Addon List
  @override
  Future<Either<Failure, ResAddonModel>> getAddonList(String token) async {
    try {
      final result = await remoteDataSource.getAddonList(token);
      final category = ResAddonModel.fromMap(result['data']);
      return Right(category);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
