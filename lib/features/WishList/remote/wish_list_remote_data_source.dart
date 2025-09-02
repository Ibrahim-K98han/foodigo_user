import 'dart:convert';

import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:http/http.dart' as http;

abstract class WishListRemoteDataSource {
  Future getWishList(String token);

  Future addToWishList(String token, int productId);

  Future removeFromWishList(String token, int wishListId);
}

class WishListRemoteDataSourceImpl implements WishListRemoteDataSource {
  final http.Client client;

  WishListRemoteDataSourceImpl({required this.client});

  authHeader(String token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        // 'Accept': "x-www-form-urlencoded/application"
      };

  ///Show Wishlist
  @override
  Future getWishList(String token) async {
    final uri = Uri.parse(RemoteUrls.getWishList);
    print('WishList====$uri');
    final clientMethod = client.get(uri, headers: authHeader(token));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  ///Add WishList
  @override
  Future addToWishList(String token, int productId) async {
    final uri = Uri.parse(RemoteUrls.addWishList); // Add your endpoint here
    print('AddWishList====$uri');

    final body = {'product_id': productId};

    final clientMethod =
        client.post(uri, headers: authHeader(token), body: jsonEncode(body));

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseJsonBody;
  }

  ///Remove Wishlist
  @override
  Future removeFromWishList(String token, int wishListId) async {
    final uri = Uri.parse(RemoteUrls.removeWishList(wishListId.toString()));
    print('RemoveWishList====$uri');
    final clientMethod = client.delete(uri, headers: authHeader(token));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }
}
