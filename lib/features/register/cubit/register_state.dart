import 'package:equatable/equatable.dart';

import '../../../data/errors/errors_model.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {
  const RegisterInitial();

  @override
  List<Object> get props => [];
}

class RegisterStateLoading extends RegisterState {}

class RegisterStateSuccess extends RegisterState {
  final String message;

  const RegisterStateSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class RegisterValidateStateError extends RegisterState {
  final Errors errors;

  const RegisterValidateStateError(this.errors);

  @override
  List<Object> get props => [errors];
}

class RegisterStateError extends RegisterState {
  final String message;
  final int statusCode;

  const RegisterStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

/// otp
class RegisterOtpStateLoading extends RegisterState {}

class RegisterOtpStateSuccess extends RegisterState {
  final String message;

  const RegisterOtpStateSuccess(this.message);

  @override
  List<Object> get props => [message];
}


class RegisterOtpStateError extends RegisterState {
  final String message;
  final int statusCode;

  const RegisterOtpStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}


class SignUpStateError extends RegisterState {
  final String errorMsg;
  final int statusCode;

  const SignUpStateError(this.errorMsg, this.statusCode);

  @override
  List<Object> get props => [errorMsg, statusCode];
}

class SignUpStateResendCodeLoaded extends RegisterState {
  final String message;

  const SignUpStateResendCodeLoaded(this.message);

  @override
  List<Object> get props => [message];
}

class LoginEventPrivacy extends RegisterState {}

class SignUpStateFormValidate extends RegisterState {
  final Errors errors;

  const SignUpStateFormValidate(this.errors);

  @override
  List<Object> get props => [errors];
}

class SignUpStateResendCodeLoading extends RegisterState {
  const SignUpStateResendCodeLoading();

  @override
  List<Object> get props => [];
}

class SignUpEventResendVerificationSubmit extends RegisterState {
  const SignUpEventResendVerificationSubmit();

  @override
  List<Object> get props => [];
}

///Create New pass
class CreateNewPassOtpStateError extends RegisterState {
  final String message;
  final int statusCode;

  const CreateNewPassOtpStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class CreateNewPassOtpStateSuccess extends RegisterState {
  final String message;

  const CreateNewPassOtpStateSuccess(this.message);

  @override
  List<Object> get props => [message];
}