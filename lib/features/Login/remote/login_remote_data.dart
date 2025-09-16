import '../../../data/network_parser.dart';
import '../../../data/remote_url.dart';
import 'package:http/http.dart' as http;

import '../model/login_state_model.dart';

abstract class LoginRemoteDataSource {
  Future login(LoginStateModel body);

  Future logout(Uri uri, String token);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final http.Client client;

  LoginRemoteDataSourceImpl({required this.client});

  authHeader(String token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        // 'Accept': "x-www-form-urlencoded/application"
      };

  final postDeleteHeader = {
    'Accept': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };

  @override
  Future login(LoginStateModel body) async {
    final uri = Uri.parse(RemoteUrls.login);
    print("login url : $uri");

    final clientMethod = client.post(
      uri,
      body: body.toMap(),
      headers: postDeleteHeader,
    );
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseJsonBody;
  }

  @override
  Future logout(Uri uri, String token) async {
    final clientMethod = client.post(uri, headers: authHeader(token));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }
}
