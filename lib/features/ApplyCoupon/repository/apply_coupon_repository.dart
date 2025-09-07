import 'package:dartz/dartz.dart';
import 'package:foodigo/features/ApplyCoupon/model/apply_coupon_response_model.dart';
import 'package:foodigo/features/ApplyCoupon/model/apply_coupon_state_model.dart';
import 'package:foodigo/features/add_to_cart/model/add_cart_response_model.dart';
import 'package:foodigo/features/checkout/model/checkout_response_model.dart';
import 'package:foodigo/features/checkout/model/checkout_state_model.dart';

import '../../../data/errors/exception.dart';
import '../../../data/errors/failure.dart';
import '../remote/apply_coupon_remote_data_source.dart';

abstract class ApplyCouponRepository {
  Future<Either<dynamic, ApplyCouponResponseModel>> applyCoupon(
      ApplyCouponStateModel body, String token);
}

class ApplyCouponRepositoryImpl implements ApplyCouponRepository {
  final ApplyCouponRemoteDataSource remoteDataSource;

  const ApplyCouponRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<dynamic, ApplyCouponResponseModel>> applyCoupon(
      ApplyCouponStateModel body, String token) async {
    try {
      final result = await remoteDataSource.applyCoupon(body, token);
      final response = ApplyCouponResponseModel.fromMap(result);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }
}
