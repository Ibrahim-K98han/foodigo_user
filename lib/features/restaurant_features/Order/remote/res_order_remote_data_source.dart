import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:http/http.dart' as http;

abstract class ResOrderRemoteDataSource {
  Future getAllOrder(String token);

  Future getOrderDetails(String token, String orderId);
}

class ResOrderRemoteDataSourceImpl implements ResOrderRemoteDataSource {
  final http.Client client;

  ResOrderRemoteDataSourceImpl({required this.client});

  authHeader(String token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        // 'Accept': "x-www-form-urlencoded/application"
      };

  ///Get All Order
  @override
  Future getAllOrder(String token) async {
    final uri = Uri.parse(RemoteUrls.getAllOrder);
    print('get all Order $uri');
    final clientMethod = client.get(uri, headers: authHeader(token));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  ///Order Details
  @override
  Future getOrderDetails(String token, String orderId) async {
    final uri = Uri.parse(RemoteUrls.getOrderDetails(orderId));
    print('get order details $uri');
    final clientMethod = client.get(uri, headers: authHeader(token));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }
}
