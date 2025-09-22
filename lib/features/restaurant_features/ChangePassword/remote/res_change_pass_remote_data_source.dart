import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../data/network_parser.dart';
import '../../../../data/remote_url.dart';
import '../model/res_change_pass_state_model.dart';

abstract class ResChangePassRemoteDataSource {
  Future changePass(ResChangePassStateModel body, String token);
}

class ResChangePassRemoteDataSourceImpl extends ResChangePassRemoteDataSource {
  final http.Client client;

  ResChangePassRemoteDataSourceImpl({required this.client});

  authHeader(String token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        // 'Accept': "x-www-form-urlencoded/application"
      };

  @override
  Future changePass(ResChangePassStateModel body, String token) async {
    final uri = Uri.parse(RemoteUrls.restaurantPassChange);
    print("ChangePass Restaurant url : $uri");
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
