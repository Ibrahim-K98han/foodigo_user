import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:http/http.dart' as http;

abstract class ResAddonRemoteDataSource {
  Future getAddonList(String token);
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
}
