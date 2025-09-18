import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:http/http.dart' as http;

abstract class RestaurantProfileRemoteDataSource {
  Future getRestaurantProfile(String token);
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
}
