import 'dart:convert';

import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/Cart/model/cart_model.dart';
import 'package:http/http.dart' as http;

abstract class CartRemoteDataSource {
  Future getCart(String token);

  Future deleteProduct(String token, String id);

  Future incrementProduct(CartModel body, String id, String token);

  Future decrementProduct(CartModel body, String id, String productId);

  Future clearCart(String token);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final http.Client client;

  CartRemoteDataSourceImpl({required this.client});

  authHeader(String token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        // 'Accept': "x-www-form-urlencoded/application"
      };

  @override
  Future getCart(String token) async {
    final uri = Uri.parse(RemoteUrls.getCartData);
    print('Cart====$uri');
    final clientMethod = client.get(uri, headers: authHeader(token));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  ///Delete Product
  @override
  Future deleteProduct(String token, String id) async {
    final uri = Uri.parse(RemoteUrls.deleteProduct(id));
    print('Product Delete====$uri');
    final clientMethod = client.delete(uri, headers: authHeader(token));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  ///Decrement Product

  @override
  Future decrementProduct(CartModel body, String id, String token) async {
    final uri = Uri.parse(RemoteUrls.decrementProduct(id));
    print('Product Decrement=====$uri');
    final clientMethod = client.post(uri,
        headers: authHeader(token),
        body: jsonEncode(
          body.toMap(),
        ));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  ///Increment Product
  @override
  Future incrementProduct(CartModel body, String id, String token) async {
    final uri = Uri.parse(RemoteUrls.incrementProduct(id));
    print('Product Increment=====$uri');
    final clientMethod = client.post(uri,
        headers: authHeader(token),
        body: jsonEncode(
          body.toMap(),
        ));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future clearCart(String token) async {
    final uri = Uri.parse(RemoteUrls.clearCart);
    print('Clear Cart ====$uri');
    final clientMethod = client.delete(uri, headers: authHeader(token));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }
}
