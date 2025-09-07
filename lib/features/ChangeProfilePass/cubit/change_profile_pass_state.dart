import 'package:equatable/equatable.dart';

import '../../../data/errors/errors_model.dart';

abstract class ChangeProfilePassState extends Equatable {
  const ChangeProfilePassState();

  @override
  List<Object> get props => [];
}

class ChangeProfilePassInitial extends ChangeProfilePassState {
  const ChangeProfilePassInitial();

  @override
  List<Object> get props => [];
}

class ChangeProfilePassStateLoading extends ChangeProfilePassState {}

class ChangeProfilePassStateSuccess extends ChangeProfilePassState {
  final String message;

  const ChangeProfilePassStateSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class ChangeProfilePassValidateStateError extends ChangeProfilePassState {
  final Errors errors;

  const ChangeProfilePassValidateStateError(this.errors);

  @override
  List<Object> get props => [errors];
}

class ChangeProfilePassStateError extends ChangeProfilePassState {
  final String message;
  final int statusCode;

  const ChangeProfilePassStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}
