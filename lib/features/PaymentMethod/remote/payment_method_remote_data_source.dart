import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:http/http.dart' as http;

abstract class PaymentMethodRemoteDataSource {
  Future getPaymentMethod(String token);
}

class PaymentMethodRemoteDataSourceImpl
    implements PaymentMethodRemoteDataSource {
  final http.Client client;

  PaymentMethodRemoteDataSourceImpl({required this.client});

  authHeader(String token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        // 'Accept': "x-www-form-urlencoded/application"
      };

  @override
  Future getPaymentMethod(String token) async {
    final uri = Uri.parse(RemoteUrls.getAllPaymentMethod);
    print('Payment Method====$uri');
    final clientMethod = client.get(uri, headers: authHeader(token));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }
}
