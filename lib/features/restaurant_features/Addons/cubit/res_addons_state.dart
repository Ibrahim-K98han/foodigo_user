import 'package:equatable/equatable.dart';
import '../model/res_addon_model.dart';

abstract class ResAddonsState extends Equatable {
  const ResAddonsState();

  @override
  List<Object?> get props => [];
}

/// Initial
class ResAddonsInitial extends ResAddonsState {
  const ResAddonsInitial();
}

/// Loading
class ResAddonsLoading extends ResAddonsState {
  const ResAddonsLoading();
}

/// Loaded
class ResAddonsLoaded extends ResAddonsState {
  final ResAddonModel resAddonModel;

  const ResAddonsLoaded(this.resAddonModel);

  @override
  List<Object?> get props => [resAddonModel];
}

/// Success
class ResAddonsSuccess extends ResAddonsState {
  final String message;

  const ResAddonsSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

/// Error
class ResAddonsError extends ResAddonsState {
  final String message;
  final int statusCode;

  const ResAddonsError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}
