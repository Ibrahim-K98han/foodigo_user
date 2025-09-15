import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';
import 'package:foodigo/features/Review/model/review_model.dart';
import 'package:foodigo/features/WishList/model/wish_list_model.dart';

import '../model/res_dashboard_model.dart';
import '../remote/res_dashboard_remote_data_source.dart';

abstract class ResDashboardRepository {
  Future<Either<Failure, ResDashboardModel>> getResDashboardData(String token);

}

class ResDashboardRepositoryImpl implements ResDashboardRepository {
  final ResDashboardRemoteDataSource remoteDataSource;

  const ResDashboardRepositoryImpl({required this.remoteDataSource});

  ///Get Dashboard data
  @override
  Future<Either<Failure, ResDashboardModel>> getResDashboardData(String token) async {
    try {
      final result = await remoteDataSource.getResDashboard(token);
      final review = ResDashboardModel.fromMap(result);
      return Right(review);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
