import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';
import 'package:foodigo/features/address/model/address_model.dart';

import '../model/address_state_model.dart';
import '../remote/get_address_remote_data_source.dart';

abstract class GetAddressRepository {
  Future<Either<Failure, List<Address>>> getAllRestaurantData(String token);

  Future<Either<Failure, bool>> deleteAddress(String token, String addressId);

  Future<Either<dynamic, Address>> addAddress(
      AddressStateModel body, String token);
}

class GetAddressRepositoryImpl implements GetAddressRepository {
  final GetAddressRemoteDataSource remoteDataSource;

  const GetAddressRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Address>>> getAllRestaurantData(
      String token) async {
    try {
      final result = await remoteDataSource.getAllAddress(token);
      final res = result['data'] as List;
      final data = List<Address>.from(res.map((e) => Address.fromMap(e)));
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteAddress(
      String token, String addressId) async {
    try {
      final result = await remoteDataSource.deleteAddress(token, addressId);
      if (result['success'] == true) {
        return Right(true);
      } else {
        return Left(ServerFailure(result['message'] ?? 'Delete failed', 400));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<dynamic, Address>> addAddress(
      AddressStateModel body, String token) async {
    try {
      final result = await remoteDataSource.addAddress(body, token);

      if (result is Map<String, dynamic> && result['data'] != null) {
        final response = Address.fromMap(result['data']);
        return Right(response);
      } else {
        return const Left(ServerFailure('Invalid response format', 500));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

}
