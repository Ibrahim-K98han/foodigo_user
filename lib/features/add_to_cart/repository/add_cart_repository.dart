import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';
import 'package:foodigo/features/add_to_cart/model/add_cart_response_model.dart';
import 'package:foodigo/features/add_to_cart/model/add_cart_state_model.dart';

import '../remote/add_cart_remote_data_source.dart';

abstract class AddCartRepository {
  Future<Either<dynamic, AddCartResponseModel>> addCart(
      AddCartStateModel body, String token);

  Future<Either<dynamic, AddCartResponseModel>> updateCart(
      AddCartStateModel body, String token, int id);
}

class AddCartRepositoryImpl implements AddCartRepository {
  final AddCartRemoteDataSource remoteDataSource;

  const AddCartRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<dynamic, AddCartResponseModel>> addCart(
      AddCartStateModel body, String token) async {
    try {
      final result = await remoteDataSource.addCart(body, token);
      final response = AddCartResponseModel.fromMap(result);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<dynamic, AddCartResponseModel>> updateCart(
      AddCartStateModel body, String token, int id) async {
    try {
      final result = await remoteDataSource.updateCart(body, token, id);
      final response = AddCartResponseModel.fromMap(result);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }
}
