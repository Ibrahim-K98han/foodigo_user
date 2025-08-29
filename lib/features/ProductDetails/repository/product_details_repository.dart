import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';
import 'package:foodigo/features/HomeData/feature_product_model.dart';

import '../remote/product_details_remote_data_source.dart';

abstract class ProductDetailsRepository {
  Future<Either<Failure, FeaturedProducts>> getProductDetailsData(int id);
}

class ProductDetailsRepositoryImpl implements ProductDetailsRepository {
  final ProductDetailsRemoteDataSource remoteDataSource;

  const ProductDetailsRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, FeaturedProducts>> getProductDetailsData(
      int id) async {
    try {
      final result = await remoteDataSource.getProductDetailsData(id);
      final data = FeaturedProducts.fromMap(result['data']);
      print('====================$data');
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
