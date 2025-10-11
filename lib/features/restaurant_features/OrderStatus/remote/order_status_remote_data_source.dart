import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:http/http.dart' as http;

abstract class OrderStatusRemoteDataSource {
  Future changeOrderStatus(String token, String orderId, String statusId);
}

class OrderStatusRemoteDataSourceImpl implements OrderStatusRemoteDataSource {
  final http.Client client;

  OrderStatusRemoteDataSourceImpl({required this.client});

  authHeader(String token) => {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
    // 'Accept': "x-www-form-urlencoded/application"
  };

  @override
  Future changeOrderStatus(String token, String orderId, String statusId) async {
    final uri = Uri.parse(RemoteUrls.changeOrderStatus(statusId));
    print('Change Order Status $uri');
    final clientMethod = client.post(uri, headers: authHeader(token));
    final responseJsonBody = await NetworkParser.callClientWithCatchException(
      () => clientMethod,
    );
    return responseJsonBody;
  }
}
