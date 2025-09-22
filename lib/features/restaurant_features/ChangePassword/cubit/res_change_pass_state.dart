import 'package:equatable/equatable.dart';

import '../../../../data/errors/errors_model.dart';

abstract class ResChangePassState extends Equatable {
  const ResChangePassState();

  @override
  List<Object> get props => [];
}

class ResChangePassInitial extends ResChangePassState {
  const ResChangePassInitial();

  @override
  List<Object> get props => [];
}

class ResChangePassStateLoading extends ResChangePassState {}

class ResChangePassStateSuccess extends ResChangePassState {
  final String message;

  const ResChangePassStateSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class ResChangePassValidateStateError extends ResChangePassState {
  final Errors errors;

  const ResChangePassValidateStateError(this.errors);

  @override
  List<Object> get props => [errors];
}

class ResChangePassStateError extends ResChangePassState {
  final String message;
  final int statusCode;

  const ResChangePassStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}
