import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:http/http.dart' as http;

abstract class OrderRemoteDataSource {
  Future getOrderData(String token);

  Future getOrderDetails(int id, String token);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final http.Client client;

  OrderRemoteDataSourceImpl({required this.client});

  authHeader(String token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        // 'Accept': "x-www-form-urlencoded/application"
      };

  @override
  Future getOrderData(String token) async {
    final uri = Uri.parse(RemoteUrls.getOrder);
    print('Order====$uri');
    final clientMethod = client.get(uri, headers: authHeader(token));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getOrderDetails(int id, String token) async {
    final uri = Uri.parse(RemoteUrls.orderDetails(id.toString()));
    print('Order Details====$uri');
    final clientMethod = client.get(uri, headers: authHeader(token));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }
}
