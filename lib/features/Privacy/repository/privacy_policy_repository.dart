import 'package:dartz/dartz.dart';
import 'package:foodigo/data/errors/exception.dart';
import 'package:foodigo/data/errors/failure.dart';
import 'package:foodigo/features/Privacy/model/privacy_response_model.dart';
import 'package:foodigo/features/Privacy/remote/privacy_policy_remote_data_source.dart';

abstract class PrivacyPolicyRepository {
  Future<Either<Failure, PrivacyResponseModel>> getPrivacyPolicy(
    String langCode,
  );
  Future<Either<Failure, TermsAndConditionResponseModel>> getTermsAndCondition(
    String langCode,
  );
  Future<Either<Failure, OfferAndReward>> getOfferAndReward(String langCode);
}

class PrivacyPolicyRepositoryImpl extends PrivacyPolicyRepository {
  final PrivacyPolicyRemoteDataSource remoteDataSource;

  PrivacyPolicyRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PrivacyResponseModel>> getPrivacyPolicy(
    String langCode,
  ) async {
    try {
      final result = await remoteDataSource.getPrivacyPolicy(langCode);
      final data = PrivacyResponseModel.fromMap(result['data']);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, TermsAndConditionResponseModel>> getTermsAndCondition(
    String langCode,
  ) async {
    try {
      final result = await remoteDataSource.getTermsAndCondition(langCode);
      final data = TermsAndConditionResponseModel.fromMap(result['data']);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, OfferAndReward>> getOfferAndReward(
    String langCode,
  ) async {
    try {
      final result = await remoteDataSource.getOfferAndReward(langCode);
      final data = OfferAndReward.fromMap(result['data']);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
