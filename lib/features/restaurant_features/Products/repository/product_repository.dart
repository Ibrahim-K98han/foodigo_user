import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';

import '../model/product_model.dart';
import '../remote/product_remote_data_source.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductModel>> getProduct(String token);
}

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  const ProductRepositoryImpl({required this.remoteDataSource});

  ///Get Product
  @override
  Future<Either<Failure, ProductModel>> getProduct(String token) async {
    try {
      final result = await remoteDataSource.getProduct(token);
      final product = ProductModel.fromMap(result['data']);
      return Right(product);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
