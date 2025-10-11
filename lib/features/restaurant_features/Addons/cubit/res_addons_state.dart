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


///============= Delete Addon =============///

class DeleteAddonLoading extends ResAddonsState {
  const DeleteAddonLoading();
}

class DeleteAddonError extends ResAddonsState {
  final String message;
  final int statusCode;

  const DeleteAddonError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

class DeleteAddonSuccess extends ResAddonsState {
  final String message;

  const DeleteAddonSuccess(this.message);

  @override
  List<Object?> get props => [message];
}



///Update Addon
class UpdateAddonsLoading extends ResAddonsState {
  const UpdateAddonsLoading();
}

class UpdateAddonsError extends ResAddonsState {
  final String message;
  final int statusCode;

  const UpdateAddonsError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

class UpdateAddonsLoaded extends ResAddonsState {
  final ResAddonModel resAddonModel;

  const UpdateAddonsLoaded(this.resAddonModel);

  @override
  List<Object?> get props => [resAddonModel];
}


///Edit Addon

class EditAddonsLoading extends ResAddonsState {
  const EditAddonsLoading();
}

class EditAddonsError extends ResAddonsState {
  final String message;
  final int statusCode;

  const EditAddonsError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

class EditAddonsLoaded extends ResAddonsState {
  final TranslateAddonModel editAddon;

  const EditAddonsLoaded(this.editAddon);

  @override
  List<Object?> get props => [editAddon];
}

///Add Addon

class AddAddonsLoading extends ResAddonsState {
  const AddAddonsLoading();
}

class AddAddonsError extends ResAddonsState {
  final String message;
  final int statusCode;

  const AddAddonsError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

class AddAddonsLoaded extends ResAddonsState {
  final TranslateAddonModel editAddon;

  const AddAddonsLoaded(this.editAddon);

  @override
  List<Object?> get props => [editAddon];
}