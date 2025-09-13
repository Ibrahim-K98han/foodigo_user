import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';
import 'package:foodigo/features/AllFood/model/all_food_model.dart';
import 'package:foodigo/features/AllFood/remote/all_food_remote_data.dart';

abstract class AllFoodRepository {
  Future<Either<Failure, List<Foods>>> getAllFood(Uri uri);
}

class AllFoodRepositoryImpl implements AllFoodRepository {
  final AllFoodRemoteDataSource remoteDataSource;

  const AllFoodRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Foods>>> getAllFood(Uri uri) async {
    try {
      final result = await remoteDataSource.getAllFood(uri);

      final res = result['data']['foods'] as List<dynamic>;
      final data = res
          .map<Foods>((e) => Foods.fromMap(e as Map<String, dynamic>))
          .toList();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(ServerFailure(e.toString(), 500));
    }
  }
}
