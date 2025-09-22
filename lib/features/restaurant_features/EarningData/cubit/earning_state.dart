import 'package:equatable/equatable.dart';
import '../model/earning_model.dart';

abstract class EarningState extends Equatable {
  const EarningState();

  @override
  List<Object?> get props => [];
}

/// Initial
class EarningStateInitial extends EarningState {
  const EarningStateInitial();
}

/// Loading
class EarningStateLoading extends EarningState {
  const EarningStateLoading();
}

/// Loaded
class EarningStateLoaded extends EarningState {
  final EarningModel earningModel;

  const EarningStateLoaded(this.earningModel);

  @override
  List<Object?> get props => [earningModel];
}

/// Success
class EarningStateSuccess extends EarningState {
  final String message;

  const EarningStateSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

/// Error
class EarningStateError extends EarningState {
  final String message;
  final int statusCode;

  const EarningStateError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}
