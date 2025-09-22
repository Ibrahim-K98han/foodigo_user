import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/errors_model.dart';
import 'package:foodigo/features/ChangeProfilePass/model/change_profile_pass_state_model.dart';
import 'package:foodigo/features/ChangeProfilePass/remote/change_profile_pass_remote_data_source.dart';
import 'package:foodigo/features/restaurant_features/ChangePassword/model/res_change_pass_state_model.dart';
import 'package:foodigo/features/restaurant_features/ChangePassword/remote/res_change_pass_remote_data_source.dart';

import '../../../../data/errors/exception.dart';
import '../../../../data/errors/failure.dart';

abstract class ResChangePassRepository {
  Future<Either<dynamic, String>> changePass(
      ResChangePassStateModel body, String token);
}

class ResChangePassRepositoryImpl implements ResChangePassRepository {
  final ResChangePassRemoteDataSource remoteDataSource;

  const ResChangePassRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<dynamic, String>> changePass(
      ResChangePassStateModel body, String token) async {
    try {
      final result = await remoteDataSource.changePass(body, token);
      if (result['success'] == false && result['data'] != null) {
        return Left(InvalidAuthData(Errors.fromMap(result['data'])));
      }
      return Right(result['message']);
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
