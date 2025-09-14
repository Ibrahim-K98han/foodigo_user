import 'dart:convert';

import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/add_to_cart/model/add_cart_state_model.dart';
import 'package:http/http.dart' as http;

abstract class AddCartRemoteDataSource {
  Future addCart(AddCartStateModel body, String token);

  Future updateCart(AddCartStateModel body, String token, int id);
}

class AddCartRemoteDataSourceImpl implements AddCartRemoteDataSource {
  final http.Client client;

  AddCartRemoteDataSourceImpl({required this.client});

  // final contentHeader = {
  //   'Accept': 'application/json',
  //   'Content-Type': 'application/json',
  //   'X-Requested-With': 'XMLHttpRequest',
  // };

  authHeader(String token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        // 'Accept': "x-www-form-urlencoded/application"
      };

  final postDeleteHeader = {
    'Accept': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };

  @override
  Future addCart(AddCartStateModel body, String token) async {
    final uri = Uri.parse(RemoteUrls.addProduct);
    print('add Cart $uri');
    final clientMethod = client.post(
      uri,
      body: jsonEncode(body.toMap()),
      headers: authHeader(token),
    );
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future updateCart(AddCartStateModel body, String token, int id) async {
    final uri = Uri.parse(RemoteUrls.updateProduct(id));
    print('Update Cart $uri');
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
