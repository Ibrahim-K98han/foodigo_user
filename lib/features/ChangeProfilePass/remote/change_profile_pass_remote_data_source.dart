import 'dart:convert';

import '../../../data/network_parser.dart';
import '../../../data/remote_url.dart';
import 'package:http/http.dart' as http;

import '../model/change_profile_pass_state_model.dart';

abstract class ChangeProfilePassRemoteDataSource {
  Future changeProfilePass(ChangeProfilePassStateModel body, String token);
}

class ChangeProfilePassRemoteDataSourceImpl
    extends ChangeProfilePassRemoteDataSource {
  final http.Client client;

  ChangeProfilePassRemoteDataSourceImpl({required this.client});

  authHeader(String token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        // 'Accept': "x-www-form-urlencoded/application"
      };

  @override
  Future changeProfilePass(
      ChangeProfilePassStateModel body, String token) async {
    final uri = Uri.parse(RemoteUrls.changeProfilePass);
    print("ChangePass url : $uri");
    final clientMethod = client.post(
      uri,
      body: jsonEncode(body.toMap()),
      headers: authHeader(token),
    );
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseJsonBody;
  }
}
