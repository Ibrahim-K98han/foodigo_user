import 'dart:convert';

import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/add_to_cart/model/add_cart_state_model.dart';
import 'package:foodigo/features/checkout/model/checkout_state_model.dart';
import 'package:http/http.dart' as http;

abstract class CheckoutRemoteDataSource {
  Future checkOut(CheckoutStateModel body, String token);
}

class CheckoutRemoteDataSourceImpl implements CheckoutRemoteDataSource {
  final http.Client client;

  CheckoutRemoteDataSourceImpl({required this.client});

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
  Future checkOut(CheckoutStateModel body, String token) async {
    final uri = Uri.parse(RemoteUrls.checkOut);
    print('Checkout ==========$uri');
    final clientMethod = client.post(uri,
        body: jsonEncode(body.toMap()), headers: authHeader(token));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }
}
