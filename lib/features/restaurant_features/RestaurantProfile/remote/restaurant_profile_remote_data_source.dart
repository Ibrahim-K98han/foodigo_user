import 'dart:convert';
import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/restaurant_features/RestaurantProfile/model/restaurant_profile_state_model.dart';
import 'package:http/http.dart' as http;

abstract class RestaurantProfileRemoteDataSource {
  Future getRestaurantProfile(String token);

  Future updateRestaurantProfile(
      RestaurantProfileStateModel body, Uri uri, String token);
}

class RestaurantProfileRemoteDataSourceImpl
    implements RestaurantProfileRemoteDataSource {
  final http.Client client;

  RestaurantProfileRemoteDataSourceImpl({required this.client});

  authHeader(String token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        // 'Accept': "x-www-form-urlencoded/application"
      };

  ///Get Restaurant Profile
  @override
  Future getRestaurantProfile(String token) async {
    final uri = Uri.parse(RemoteUrls.getRestaurantProfile);
    print('Restaurant Profile====$uri');
    final clientMethod = client.get(uri, headers: authHeader(token));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  ///Update Profile
  @override
  Future updateRestaurantProfile(
      RestaurantProfileStateModel body, Uri uri, String token) async {
    final request = http.MultipartRequest('POST', uri);
    request.fields.addAll(
        body.toMap().map((key, value) => MapEntry(key, value.toString())));

    if (body.coverImages.isNotEmpty) {
      final file = await http.MultipartFile.fromPath('cover_image', body.coverImages);
      request.files.add(file);
    }
    if (body.logo.isNotEmpty) {
      final file = await http.MultipartFile.fromPath('logo', body.logo);
      request.files.add(file);
    }

    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }
}
