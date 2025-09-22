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

  /// --------- UPDATE PRODUCT -------------
  @override
  Future updateStoreProduct(
      StoreProductStateModel body, Uri uri, String token) async {
    final request = http.MultipartRequest('POST', uri);

    // Prepare map
    final map = body.toMap();

    // Remove empty fields
    map.removeWhere((k, v) =>
        v == null ||
        v.toString().isEmpty ||
        (v is List && v.isEmpty)); // Remove empty lists

    // Convert list fields to JSON string
    if (map['size'] is List) map['size'] = json.encode(map['size']);
    if (map['price'] is List) map['price'] = json.encode(map['price']);

    // Add fields to request
    request.fields.addAll(map.map((k, v) => MapEntry(k, v.toString())));

    // Debug print fields
    print('--- Sending fields ---');
    request.fields.forEach((k, v) => print('$k : $v'));

    // Add image if exists
    if (body.image.isNotEmpty) {
      try {
        final file = await http.MultipartFile.fromPath('image', body.image);
        request.files.add(file);
        print('--- Sending files ---');
        print('Image file: ${file.filename}');
      } catch (e) {
        print('Error adding image file: $e');
      }
    } else {
      print('No image attached');
    }

    // Add headers
    request.headers.addAll(authHeader(token));

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('--- API Response ---');
      print('Status Code: ${response.statusCode}');
      print('Body: ${response.body}');

      final responseJson = json.decode(response.body);

      // Return product if exists
      if (responseJson['data'] != null &&
          responseJson['data']['product'] != null) {
        return responseJson['data']['product'];
      } else {
        throw Exception(
          'API response missing product data: ${response.body}',
        );
      }
    } catch (e) {
      print('Exception during API call: $e');
      rethrow;
    }
  }
}
