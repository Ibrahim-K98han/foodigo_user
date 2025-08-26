import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:http/http.dart' as http;


abstract class HomeDataRemoteDataSource {
  Future getHomeData();
}


class HomeDataRemoteDataSourceImpl implements HomeDataRemoteDataSource {
  final http.Client client;

  HomeDataRemoteDataSourceImpl({required this.client});

  final contentHeader = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };

  @override
  Future getHomeData() async {
    final uri = Uri.parse(RemoteUrls.homeData);
    print('====================$uri');
    final clientMethod = client.get(uri, headers: contentHeader);
    final responseJsonBody = await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }
}
