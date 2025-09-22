import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:http/http.dart' as http;

abstract class EarningRemoteDataSource {
  Future getEarning(String token);

}

class EarningRemoteDataSourceImpl implements EarningRemoteDataSource {
  final http.Client client;

  EarningRemoteDataSourceImpl({required this.client});

  authHeader(String token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        // 'Accept': "x-www-form-urlencoded/application"
      };

  /// Get Earning
  @override
  Future getEarning(String token) async {
    final uri = Uri.parse(RemoteUrls.getEarning);
    print('get Earning $uri');
    final clientMethod = client.get(uri, headers: authHeader(token));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseJsonBody;
  }

}
