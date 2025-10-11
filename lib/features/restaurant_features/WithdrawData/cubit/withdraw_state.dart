import 'package:equatable/equatable.dart';
import 'package:foodigo/data/errors/errors_model.dart';

import '../model/withdraw_model.dart';

abstract class WithdrawState extends Equatable {
  const WithdrawState();

  @override
  List<Object?> get props => [];
}

/// Initial
class WithdrawMethodInitial extends WithdrawState {
  const WithdrawMethodInitial();
}

/// Loading
class WithdrawMethodLoading extends WithdrawState {
  const WithdrawMethodLoading();
}

/// Loaded
class WithdrawMethodLoaded extends WithdrawState {
  final WithdrawModel withdrawModel;

  const WithdrawMethodLoaded(this.withdrawModel);

  @override
  List<Object?> get props => [withdrawModel];
}

/// Success
class WithdrawMethodSuccess extends WithdrawState {
  final String message;

  const WithdrawMethodSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

/// Error
class WithdrawMethodError extends WithdrawState {
  final String message;
  final int statusCode;

  const WithdrawMethodError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

class WithdrawStoreLoaded extends WithdrawState {
  final NewWithdrawResponse withdraw;

  const WithdrawStoreLoaded(this.withdraw);

  @override
  List<Object?> get props => [withdraw];
}

class WithdrawValidateStateError extends WithdrawState {
  final Errors errors;

  const WithdrawValidateStateError(this.errors);

  @override
  List<Object> get props => [errors];
}
