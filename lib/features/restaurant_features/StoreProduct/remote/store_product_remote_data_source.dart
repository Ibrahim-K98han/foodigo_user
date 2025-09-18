import 'dart:convert';
import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/add_to_cart/model/add_cart_state_model.dart';
import 'package:foodigo/features/restaurant_features/StoreProduct/model/store_product_state_model.dart';
import 'package:http/http.dart' as http;

abstract class StoreProductRemoteDataSource {
  Future storeProduct(StoreProductStateModel body, Uri uri, String token);

  Future updateCart(AddCartStateModel body, String token, int id);
}

class StoreProductRemoteDataSourceImpl implements StoreProductRemoteDataSource {
  final http.Client client;

  StoreProductRemoteDataSourceImpl({required this.client});

  authHeader(String token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

  @override
  Future storeProduct(
      StoreProductStateModel body, Uri uri, String token) async {
    final request = http.MultipartRequest('POST', uri);
    request.fields.addAll(
        body.toMap().map((key, value) => MapEntry(key, value.toString())));
    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    if (body.image.isNotEmpty) {
      final file = await http.MultipartFile.fromPath('image', body.image);
      request.files.add(file);
    }

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['data']['product']; // nested থেকে product আনতে হবে
  }

  @override
  Future updateCart(AddCartStateModel body, String token, int id) async {
    final uri = Uri.parse(RemoteUrls.updateProduct(id));
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
