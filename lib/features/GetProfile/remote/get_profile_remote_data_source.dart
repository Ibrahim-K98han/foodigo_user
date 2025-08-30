import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:http/http.dart' as http;

abstract class GetProfileRemoteDataSource {
  Future getProfileData(String token);
}

class GetProfileRemoteDataSourceImpl implements GetProfileRemoteDataSource {
  final http.Client client;

  GetProfileRemoteDataSourceImpl({required this.client});

  authHeader(String token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        // 'Accept': "x-www-form-urlencoded/application"
      };

  @override
  Future getProfileData( String token) async {
    final uri = Uri.parse(RemoteUrls.getProfile);
    // print('profile$uri');
    final clientMethod = client.get(uri, headers: authHeader(token));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }
}
