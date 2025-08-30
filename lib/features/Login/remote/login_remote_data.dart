import '../../../data/network_parser.dart';
import '../../../data/remote_url.dart';
import '../model/login_state_model.dart';
import 'package:http/http.dart' as http;

abstract class LoginRemoteDataSource {
  Future login(LoginStateModel body);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final http.Client client;

  LoginRemoteDataSourceImpl({required this.client});

  final contentHeader = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
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
}
