import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';
import 'package:foodigo/features/address/model/address_model.dart';

import '../model/address_state_model.dart';
import '../remote/get_address_remote_data_source.dart';

abstract class GetAddressRepository {
  Future<Either<Failure, List<Address>>> getAllAddressData(String token);

  Future<Either<Failure, bool>> deleteAddress(String token, String addressId);

  Future<Either<dynamic, Address>> addAddress(
      AddressStateModel body, String token);

  Future<Either<dynamic, Address>> updateAddress(
      AddressStateModel body, String token, String addressId);
}

class GetAddressRepositoryImpl implements GetAddressRepository {
  final GetAddressRemoteDataSource remoteDataSource;

  const GetAddressRepositoryImpl({
    required this.remoteDataSource,
  });

  ///Show All Address
  @override
  Future<Either<Failure, List<Address>>> getAllAddressData(String token) async {
    try {
      final result = await remoteDataSource.getAllAddress(token);
      final res = result['data'] as List;
      final data = List<Address>.from(res.map((e) => Address.fromMap(e)));
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  ///delete Address
  @override
  Future<Either<Failure, bool>> deleteAddress(
      String token, String addressId) async {
    try {
      final result = await remoteDataSource.deleteAddress(token, addressId);
      if (result['success'] == true) {
        return const Right(true);
      } else {
        return Left(ServerFailure(result['message'] ?? 'Delete failed', 400));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  ///Add Address
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

  ///Update Address
  @override
  Future<Either<dynamic, Address>> updateAddress(
      AddressStateModel body, String token, String addressId) async {
    try {
      final result =
          await remoteDataSource.updateAddress(body, token, addressId);
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
