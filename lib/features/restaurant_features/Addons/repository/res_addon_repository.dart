import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';

import '../model/res_addon_model.dart';
import '../model/res_addon_state_model.dart';
import '../remote/res_addon_remote_data_source.dart';

abstract class ResAddonRepository {
  Future<Either<Failure, ResAddonModel>> getAddonList(String token);

  Future<Either<Failure, ResAddonModel>> storeAddon(
    ResAddonStateModel body,
    String token,
  );
  Future<Either<Failure, ResAddons>> updateAddon(
    ResAddonStateModel body,
    Uri url,
    String token,
    String id,
  );

  Future<Either<Failure, String>> deleteAddon(
    String token,
    String id,
  ); // String করুন

  Future<Either<Failure, TranslateAddonModel>> editAddon(
    String token,
    String id,
    Uri url,
  );
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

  /// Store Addon
  @override
  Future<Either<Failure, ResAddonModel>> storeAddon(
    ResAddonStateModel body,
    String token,
  ) async {
    try {
      final result = await remoteDataSource.storeAddon(body, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(ServerFailure(e.toString(), 500));
    }
  }

  // ///Delete Addon
  // @override
  // Future<Either<Failure, ResAddonModel>> deleteAddon(
  //   String token,
  //   String id,
  // ) async {
  //   try {
  //     final result = await remoteDataSource.deleteAddon(token, id);
  //     final data = ResAddonModel.fromMap(result);
  //     return Right(data);
  //   } on ServerException catch (e) {
  //     return Left(ServerFailure(e.message, e.statusCode));
  //   }
  // }

  ///Delete Addon
  @override
  Future<Either<Failure, String>> deleteAddon(String token, String id) async {
    try {
      final result = await remoteDataSource.deleteAddon(token, id);
      final message = result['data'] as String;
      return Right(message);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  ///Edit addon
  @override
  Future<Either<Failure, TranslateAddonModel>> editAddon(
    String token,
    String id,
    Uri url,
  ) async {
    try {
      final result = await remoteDataSource.editAddon(token, id, url);
      final data = TranslateAddonModel.fromMap(result['data']);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  ///Update Addon
  @override
  Future<Either<Failure, ResAddons>> updateAddon(
    ResAddonStateModel body,
    Uri url,
    String token,
    String id,
  ) async {
    try {
      final result = await remoteDataSource.updateAddon(body, url, token, id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(ServerFailure(e.toString(), 500));
    }
  }
}
