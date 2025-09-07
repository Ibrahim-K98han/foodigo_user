import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:http/http.dart' as http;

import '../model/payment_method_response_model.dart';

abstract class PaymentMethodRemoteDataSource {
  Future<PaymentMethodModel> getPaymentMethod(String token);
}

class PaymentMethodRemoteDataSourceImpl
    implements PaymentMethodRemoteDataSource {
  final http.Client client;

  PaymentMethodRemoteDataSourceImpl({required this.client});

  Map<String, String> authHeader(String token) => {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  };

  @override
  Future<PaymentMethodModel> getPaymentMethod(String token) async {
    final uri = Uri.parse(RemoteUrls.getAllPaymentMethod);
    print('📡 Payment Method API Call => $uri');
    final clientMethod = client.get(uri, headers: authHeader(token));
    final responseJsonBody =
    await NetworkParser.callClientWithCatchException(() => clientMethod);
    final data = responseJsonBody["data"]["payment_methods"];

    return PaymentMethodModel.fromMap(data);
  }
}
