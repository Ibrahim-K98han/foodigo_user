import 'package:equatable/equatable.dart';

import '../../../data/errors/errors_model.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordStateInitial extends ForgotPasswordState {
  const ForgotPasswordStateInitial();

  @override
  List<Object> get props => [];
}

class ForgotPasswordStateLoading extends ForgotPasswordState {
  const ForgotPasswordStateLoading();

  @override
  List<Object> get props => [];
}

class ForgotPasswordOtpStateLoading extends ForgotPasswordState {}

class ForgotPasswordStateError extends ForgotPasswordState {
  const ForgotPasswordStateError(this.message, this.statusCode);

  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

class VerifyingForgotPasswordError extends ForgotPasswordState {
  const VerifyingForgotPasswordError(this.message);

  final String message;
  @override
  List<Object> get props => [message];
}

class ForgotPasswordFormValidateError extends ForgotPasswordState {
  const ForgotPasswordFormValidateError(this.errors);

  final Errors errors;

  @override
  List<Object> get props => [errors];
}

class ForgotPasswordStateLoaded extends ForgotPasswordState {
  const ForgotPasswordStateLoaded(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class ForgotPasswordStateSuccess extends ForgotPasswordState {
  final String message;

  const ForgotPasswordStateSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class VerifyingForgotPasswordLoaded extends ForgotPasswordState {
  const VerifyingForgotPasswordLoaded(this.message,);

  final String message;
  // final String success;
  @override
  List<Object> get props => [message];
}


class PasswordStateUpdated extends ForgotPasswordState {
  const PasswordStateUpdated(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class VerifyingForgotPasswordCodeLoaded extends ForgotPasswordState {
  const VerifyingForgotPasswordCodeLoaded();

  @override
  List<Object> get props => [];
}

class VerifyingForgotPasswordLoading extends ForgotPasswordState {
  const VerifyingForgotPasswordLoading();

  @override
  List<Object> get props => [];
}

class ForgotPssOtpStateError extends ForgotPasswordState {
  final String message;
  final int statusCode;

  const ForgotPssOtpStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class ForgotPassOtpStateSuccess extends ForgotPasswordState {
  final String message;

  const ForgotPassOtpStateSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class  ForgotPassOtpStateLoading extends ForgotPasswordState {}

///Forgot pass otp verify
class  ForgotPassOtpVerifyStateLoading extends ForgotPasswordState {}

class ForgotPssOtpVerifyStateError extends ForgotPasswordState {
  final String message;
  final int statusCode;

  const ForgotPssOtpVerifyStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class ForgotPassOtpVerifyStateSuccess extends ForgotPasswordState {
  final String message;

  const ForgotPassOtpVerifyStateSuccess(this.message);

  @override
  List<Object> get props => [message];
}

///Reset pass
class ForgotPasswordResetStateLoading extends ForgotPasswordState {
  const ForgotPasswordResetStateLoading();

  @override
  List<Object> get props => [];
}

class ForgotPasswordResetFormValidateError extends ForgotPasswordState {
  const ForgotPasswordResetFormValidateError(this.errors);

  final Errors errors;

  @override
  List<Object> get props => [errors];
}

class ForgotPasswordResetStateError extends ForgotPasswordState {
  const ForgotPasswordResetStateError(this.message, this.statusCode);

  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

class PasswordResetStateUpdated extends ForgotPasswordState {
  const PasswordResetStateUpdated(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}


class SetPasswordStateLoading extends ForgotPasswordState {
  const SetPasswordStateLoading();
  @override
  List<Object> get props => [];
}

class SetPasswordStateError extends ForgotPasswordState {
  const SetPasswordStateError(this.message, this.statusCode);

  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

class SetForgotPasswordLoaded extends ForgotPasswordState {
  const SetForgotPasswordLoaded(this.message,);

  final String message;
  @override
  List<Object> get props => [message];
}