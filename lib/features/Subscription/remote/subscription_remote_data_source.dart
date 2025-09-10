import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../data/network_parser.dart';
import '../../../data/remote_url.dart';
import '../model/bank_payment_request_model.dart';

abstract class SubscriptionRemoteDataSource {
  Future payWithBank(BankPaymentRequestModel body, String token);

  // Future payWithStripe(Uri url);
}

class SubscriptionRemoteDataSourceImpl implements SubscriptionRemoteDataSource {
  final http.Client client;

  SubscriptionRemoteDataSourceImpl({required this.client});

  authHeader(String token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        // 'Accept': "x-www-form-urlencoded/application"
      };

  final postDeleteHeader = {
    'Accept': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };

  @override
  Future payWithBank(BankPaymentRequestModel body, String token) async {
    final uri = Uri.parse(RemoteUrls.payWithBank);
    print('Bank Payment $uri');
    final clientMethod = client.post(
      uri,
      body: jsonEncode(body.toMap()),
      headers: authHeader(token),
    );

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }
  //
  // @override
  // Future payWithStripe(Uri url) async {
  //   final clientMethod =
  //   client.get(url, headers: postDeleteHeader, );
  //   final responseJsonBody =
  //   await NetworkParser.callClientWithCatchException(() => clientMethod);
  //   return responseJsonBody['message'] as String;
  // }
}
