import 'package:equatable/equatable.dart';

import '../../../data/errors/errors_model.dart';

abstract class ForgotPasswordVerifyState extends Equatable {
  const ForgotPasswordVerifyState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordVerifyStateInitial extends ForgotPasswordVerifyState {
  const ForgotPasswordVerifyStateInitial();
  @override
  List<Object> get props => [];
}


class VerifyingForgotPasswordLoading extends ForgotPasswordVerifyState {
  const VerifyingForgotPasswordLoading();

  @override
  List<Object> get props => [];
}

class VerifyingForgotPasswordError extends ForgotPasswordVerifyState {
  const VerifyingForgotPasswordError(this.message);

  final String message;
  @override
  List<Object> get props => [message];
}
class VerifyingForgotPasswordLoaded extends ForgotPasswordVerifyState {
  const VerifyingForgotPasswordLoaded(this.message,);

  final String message;
  // final String success;
  @override
  List<Object> get props => [message];
}