import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:http/http.dart' as http;

abstract class SplashRemoteDataSource {
  Future getSplash();
}

class SplashRemoteDataSourceImpl implements SplashRemoteDataSource {
  final http.Client client;

  SplashRemoteDataSourceImpl({required this.client});

  authHeader(String token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        // 'Accept': "x-www-form-urlencoded/application"
      };

  @override
  Future getSplash() async {
    final uri = Uri.parse(RemoteUrls.splashScreen);
    print('Splash====$uri');
    final clientMethod = client.get(uri,);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }
}
