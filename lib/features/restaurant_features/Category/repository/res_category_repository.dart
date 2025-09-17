import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';

import '../model/res_category_model.dart';
import '../remote/res_category_remote_data_source.dart';

abstract class ResCategoryRepository {
  Future<Either<Failure, ResCategoryModel>> getCategoryList(String token);
}

class ResCategoryRepositoryImpl implements ResCategoryRepository {
  final ResCategoryRemoteDataSource remoteDataSource;

  const ResCategoryRepositoryImpl({required this.remoteDataSource});

  /// Get Category List
  @override
  Future<Either<Failure, ResCategoryModel>> getCategoryList(
      String token) async {
    try {
      final result = await remoteDataSource.getCategoryList(token);
      final category = ResCategoryModel.fromMap(result['data']);
      return Right(category);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
