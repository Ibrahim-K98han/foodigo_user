import 'dart:convert';

import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/restaurant_features/Addons/model/res_addon_state_model.dart';
import 'package:http/http.dart' as http;

import '../model/res_addon_model.dart';

abstract class ResAddonRemoteDataSource {
  Future getAddonList(String token);

  Future storeAddon(ResAddonStateModel body, String token);

  Future updateAddon(ResAddonStateModel body, Uri url, String token, String id);

  Future deleteAddon(String token, String id);

  Future editAddon(String token, String id, Uri url);
}

class ResAddonRemoteDataSourceImpl implements ResAddonRemoteDataSource {
  final http.Client client;

  ResAddonRemoteDataSourceImpl({required this.client});

  authHeader(String token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        // 'Accept': "x-www-form-urlencoded/application"
      };

  /// Get Addon List
  @override
  Future getAddonList(String token) async {
    final uri = Uri.parse(RemoteUrls.getAddon);
    print('get Addon List $uri');
    final clientMethod = client.get(uri, headers: authHeader(token));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseJsonBody;
  }

  /// Store Addon
  @override
  Future storeAddon(ResAddonStateModel body, String token) async {
    final uri = Uri.parse(RemoteUrls.storeAddon);
    print('Store Addon $uri');
    final clientMethod = client.post(
      uri,
      headers: authHeader(token),
      body: jsonEncode(body.toMap()),
    );

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    final addonData = responseJsonBody['data']['addon'];
    return ResAddonModel(resAddons: [ResAddons.fromMap(addonData)]);
  }

  ///delete addon
  @override
  Future deleteAddon(String token, String id) async {
    final uri = Uri.parse(RemoteUrls.deleteAddon(id));
    print('Delete Addon====$uri');
    final clientMethod = client.get(uri, headers: authHeader(token));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  ///Edit Addon
  @override
  Future editAddon(String token, String id, Uri url) async {
    final clientMethod = client.get(url, headers: authHeader(token));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  ///Update addon
  @override
  Future updateAddon(
      ResAddonStateModel body, Uri url, String token, String id) async {
    final request = http.MultipartRequest('POST', url);
    request.fields.addAll(
        body.toMap().map((key, value) => MapEntry(key, value.toString())));
    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    print('Body print: ${body.toMap()}');

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['data']['addon'];
  }
}
