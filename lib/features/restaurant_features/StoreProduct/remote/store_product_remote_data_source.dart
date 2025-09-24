import 'dart:convert';

import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/features/restaurant_features/StoreProduct/model/store_product_state_model.dart';
import 'package:http/http.dart' as http;

import '../../../../data/remote_url.dart';

abstract class StoreProductRemoteDataSource {
  Future storeProduct(StoreProductStateModel body, Uri uri, String token);

  Future updateStoreProduct(StoreProductStateModel body, Uri uri, String token);

  Future getEditProduct(String token, String id, Uri url);

  Future deleteStoreProduct(String token, String id);
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
    request.fields['size'] = jsonEncode(body.size);
    request.fields['price'] = jsonEncode(body.price);

    if (body.image.isNotEmpty) {
      final file = await http.MultipartFile.fromPath('image', body.image);
      request.files.add(file);
    }

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['data']['product'];
  }

  /// --------- UPDATE PRODUCT -------------
  @override
  Future updateStoreProduct(
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
    return responseJsonBody['data']['product'];
  }

  /// --------- GET PRODUCT BY ID -------------
  @override
  Future getEditProduct(String token, String id, Uri url) async {
    final clientMethod = client.get(url, headers: authHeader(token));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  ///delete store product
  @override
  Future deleteStoreProduct(String token, String id) async {
    final uri = Uri.parse(RemoteUrls.deleteStoreProduct(id));
    print('Delete Store product====$uri');
    final clientMethod = client.get(uri, headers: authHeader(token));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }
}
