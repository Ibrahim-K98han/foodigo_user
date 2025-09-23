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
  Future updateStoreProduct(StoreProductStateModel body, Uri uri, String token) async {
    final request = http.MultipartRequest('POST', uri);

    // ---------------- সাধারণ ফিল্ড ----------------
    request.fields['name'] = body.name;
    request.fields['slug'] = body.slug;
    request.fields['category_id'] = body.categoryId.isNotEmpty ? body.categoryId : '0';
    request.fields['addon'] = body.addonId.isNotEmpty ? body.addonId : '0';
    request.fields['product_price'] = body.productPrice.isNotEmpty ? body.productPrice : '0';
    request.fields['offer_price'] = body.offerPrice.isNotEmpty ? body.offerPrice : '0';
    request.fields['short_description'] = body.shortDescription;

    // translate_id must
    request.fields['translate_id'] = body.translateId.isNotEmpty ? body.translateId : '0';

    // ---------------- Size & Price ----------------
    for (int i = 0; i < body.size.length; i++) {
      request.fields['size[$i]'] = body.size[i];
      request.fields['price[$i]'] = body.price[i];
    }

    // ---------------- Image Attach ----------------
    if (body.image.isNotEmpty) {
      try {
        final file = await http.MultipartFile.fromPath('image', body.image);
        request.files.add(file);
        print('Image attached: ${body.image}, length: ${file.length} bytes');
      } catch (e) {
        print('Failed to attach image: $e');
      }
    } else {
      print('No image to attach');
    }

    // ---------------- Headers ----------------
    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    // ---------------- Debug ----------------
    print('==== Update Product Fields ====');
    request.fields.forEach((key, value) {
      print('$key => $value');
    });

    if (request.files.isNotEmpty) {
      for (var f in request.files) {
        print('File field: ${f.filename}, length: ${f.length}');
      }
    }

    // ---------------- API Call ----------------
    final response = await request.send();
    final res = await http.Response.fromStream(response);

    final responseJsonBody =
    await NetworkParser.callClientWithCatchException(() => Future.value(res));

    return responseJsonBody['data']['product'];
  }


}
