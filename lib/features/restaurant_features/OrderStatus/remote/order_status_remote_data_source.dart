import 'dart:convert';
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
        'Content-Type': 'application/x-www-form-urlencoded',
      };

  @override
  Future changeOrderStatus(
      String token, String orderId, String statusId) async {
    final uri = Uri.parse(RemoteUrls.changeOrderStatus(orderId));
    print('Change Order Status URI: $uri');

    // Prepare the body with order_status parameter
    final body = {
      'order_status': statusId,
    };

    print('Request Body: $body');

    final clientMethod = client.post(
      uri,
      headers: authHeader(token),
      body: body,
    );

    final responseJsonBody = await NetworkParser.callClientWithCatchException(
      () => clientMethod,
    );

    return responseJsonBody;
  }
}
