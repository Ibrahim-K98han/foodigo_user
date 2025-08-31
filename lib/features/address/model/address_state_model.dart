// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';

import '../cubit/get_address_state.dart';

class AddressStateModel extends Equatable {
  final String type;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String landmark;
  final String latitude;
  final String longitude;
  final AllAddressState addressState;

  const AddressStateModel({
    this.type = '',
    this.name = '',
    this.email = '',
    this.phone = '',
    this.address = '',
    this.landmark = '',
    this.latitude ='',
    this.longitude = '',
    this.addressState =  const AllAddressInitial(),
  });

  AddressStateModel copyWith({
    String? type,
    String? name,
    String? email,
    String? phone,
    String? address,
    String? landmark,
    String? latitude,
    String? longitude,
    AllAddressState? addressState,
  }) {
    return AddressStateModel(
      type: type ?? this.type,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      landmark: landmark ?? this.landmark,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      addressState: addressState ?? this.addressState,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'landmark': landmark,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory AddressStateModel.fromMap(Map<String, dynamic> map) {
    return AddressStateModel(
      type: map['type'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      landmark: map['landmark'] ?? '',
      latitude: (map['latitude'] ?? 0).toDouble(),
      longitude: (map['longitude'] ?? 0).toDouble(),
      addressState: const AllAddressInitial(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressStateModel.fromJson(String source) =>
      AddressStateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [
    type,
    name,
    email,
    phone,
    address,
    landmark,
    latitude,
    longitude,
    addressState,
  ];
}
