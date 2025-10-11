import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';
import 'package:foodigo/features/restaurant_features/RestaurantDashboard/remote/res_dashboard_remote_data_source.dart';
import '../model/res_dashboard_model.dart';

abstract class ResDashboardRepository {
  Future<Either<Failure, ResDashboardModel>> getResDashboardData(String token);
}

class ResDashboardRepositoryImpl implements ResDashboardRepository {
  final ResDashboardRemoteDataSource remoteDataSource;

  const ResDashboardRepositoryImpl({required this.remoteDataSource});

  ///Get Dashboard data
  @override
  Future<Either<Failure, ResDashboardModel>> getResDashboardData(
    String token,
  ) async {
    try {
      final result = await remoteDataSource.getResDashboard(token);
      final review = ResDashboardModel.fromMap(result['data']);
      return Right(review);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
