import 'package:equatable/equatable.dart';
import 'package:foodigo/features/Review/model/review_model.dart';
import 'package:foodigo/features/Splash/model/splash_response_model.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashStateInitial extends SplashState {
  const SplashStateInitial();

  @override
  List<Object?> get props => [];
}

class SplashStateLoading extends SplashState {
  const SplashStateLoading();

  @override
  List<Object?> get props => [];
}

class SplashStateLoaded extends SplashState {
  final SplashResponseModel splashResponseModel;

  const SplashStateLoaded(this.splashResponseModel);

  @override
  List<Object?> get props => [splashResponseModel];
}

class SplashStateSuccess extends SplashState {
  final SplashResponseModel splashResponseModel;

  const SplashStateSuccess(this.splashResponseModel);

  @override
  List<Object?> get props => [splashResponseModel];
}

class SplashStateError extends SplashState {
  final String message;
  final int statusCode;

  const SplashStateError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}
