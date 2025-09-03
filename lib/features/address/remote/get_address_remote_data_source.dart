import 'dart:convert';

import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/address/model/address_state_model.dart';
import 'package:http/http.dart' as http;

abstract class GetAddressRemoteDataSource {
  Future getAllAddress(String token);

  Future deleteAddress(String token, String addressId);

  Future addAddress(AddressStateModel body, String token);

  Future updateAddress(AddressStateModel body, String token, String addressId);
}

class GetAddressRemoteDataSourceImpl implements GetAddressRemoteDataSource {
  final http.Client client;

  GetAddressRemoteDataSourceImpl({required this.client});

  authHeader(String token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

  ///Show All Address
  @override
  Future getAllAddress(String token) async {
    final uri = Uri.parse(RemoteUrls.getAddress);
    print('address $uri');

    final clientMethod = client.get(uri, headers: authHeader(token));

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  ///Delete Address
  @override
  Future deleteAddress(String token, String addressId) async {
    final uri = Uri.parse(RemoteUrls.deleteAddress(addressId));
    print('delete address $uri');

    final clientMethod = client.delete(uri, headers: authHeader(token));

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  ///Add Address
  @override
  Future addAddress(AddressStateModel body, String token) async {
    final uri = Uri.parse(RemoteUrls.addAddress);
    print('Add Address $uri');
    final clientMethod = client.post(
      uri,
      body: jsonEncode(body.toMap()),
      headers: authHeader(token),
    );
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  ///Update Address
  @override
  Future updateAddress(
      AddressStateModel body, String token, String addressId) async {
    final uri = Uri.parse(RemoteUrls.updateAddress(addressId));
    print('Update Address $uri');

    final clientMethod = client.put(
      uri,
      body: jsonEncode(body.toMap()),
      headers: authHeader(token),
    );

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }
}
