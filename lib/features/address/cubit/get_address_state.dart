import 'package:foodigo/features/HomeData/restaurant_model.dart';
import 'package:foodigo/features/address/model/address_model.dart';

abstract class AllAddressState {}

class AllAddressInitial extends AllAddressState {}

class AllAddressLoading extends AllAddressState {}

class AllAddressLoaded extends AllAddressState {
  final List<Address> getAddress;

  AllAddressLoaded(this.getAddress);
}

class AAllAddressError extends AllAddressState {
  final String message;
  final int statusCode;

  AAllAddressError(this.message, this.statusCode);
}
