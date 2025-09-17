import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:http/http.dart' as http;

abstract class ResCategoryRemoteDataSource {
  Future getCategoryList(String token);
}

class ResCategoryRemoteDataSourceImpl implements ResCategoryRemoteDataSource {
  final http.Client client;

  ResCategoryRemoteDataSourceImpl({required this.client});

  authHeader(String token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        // 'Accept': "x-www-form-urlencoded/application"
      };

  /// Get Category List
  @override
  Future getCategoryList(String token) async {
    final uri = Uri.parse(RemoteUrls.getCategoryList);
    print('get Category List $uri');
    final clientMethod = client.get(uri, headers: authHeader(token));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseJsonBody;
  }
}
