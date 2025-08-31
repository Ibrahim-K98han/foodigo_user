import 'package:equatable/equatable.dart';
import 'package:foodigo/features/address/model/address_model.dart';

import '../../../data/errors/errors_model.dart';

abstract class AllAddressState extends Equatable {
  const AllAddressState();
}

class AllAddressInitial extends AllAddressState {
  const AllAddressInitial();

  @override
  List<Object?> get props => [];
}

class AllAddressLoading extends AllAddressState {
  @override
  List<Object?> get props => [];
}

class AddAddressStateLoading extends AllAddressState {
  @override
  List<Object?> get props => [];
}

class AddAddressStateFormValidate extends AllAddressState {
  final Errors errors;

  const AddAddressStateFormValidate(this.errors);

  @override
  List<Object?> get props => [errors];
}

class AddAddressStateSuccess extends AllAddressState {
  final Address address;

  const AddAddressStateSuccess(this.address);

  @override
  List<Object> get props => [address];
}

class AddAddresstStateError extends AllAddressState {
  final String message;
  final int statusCode;

  const AddAddresstStateError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

class AllAddressLoaded extends AllAddressState {
  final List<Address> getAddress;

  const AllAddressLoaded(this.getAddress);

  @override
  List<Object?> get props => [getAddress];
}

class AAllAddressError extends AllAddressState {
  final String message;
  final int statusCode;

  const AAllAddressError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message];
}

class DeleteAddressLoading extends AllAddressState {
  final String addressId;

  const DeleteAddressLoading(this.addressId);

  @override
  List<Object?> get props => [addressId];
}

class DeleteAddressError extends AllAddressState {
  final String message;
  final int statusCode;

  const DeleteAddressError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message];
}

class AddressAdding extends AllAddressState {
  @override
  List<Object?> get props => [];
}

class AddressAdded extends AllAddressState {
  final Address address;

  const AddressAdded(this.address);

  @override
  List<Object?> get props => [address];
}
