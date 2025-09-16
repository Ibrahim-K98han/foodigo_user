import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:http/http.dart' as http;

abstract class ResDashboardRemoteDataSource {
  Future getResDashboard(String token);
}

class ResDashboardRemoteDataSourceImpl implements ResDashboardRemoteDataSource {
  final http.Client client;

  ResDashboardRemoteDataSourceImpl({required this.client});

  authHeader(String token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        // 'Accept': "x-www-form-urlencoded/application"
      };

  ///Get Restaurant Dashboard
  @override
  Future getResDashboard(String token) async {
    final uri = Uri.parse(RemoteUrls.getRestaurantDashboard);
    print('Restaurant Dashboard====$uri');
    final clientMethod = client.get(uri, headers: authHeader(token));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }
}
