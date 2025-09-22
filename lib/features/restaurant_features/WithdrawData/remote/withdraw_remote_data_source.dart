import 'dart:convert';

import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:http/http.dart' as http;

import '../model/withdraw_store_state_model.dart';

abstract class WithdrawRemoteDataSource {
  Future getWithdrawMethod(String token);
  Future addNewWithdraw(WithdrawStoreStateModel body, String token);
}

class WithdrawRemoteDataSourceImpl implements WithdrawRemoteDataSource {
  final http.Client client;

  WithdrawRemoteDataSourceImpl({required this.client});

  authHeader(String token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        // 'Accept': "x-www-form-urlencoded/application"
      };

  /// Get Withdraw Method
  @override
  Future getWithdrawMethod(String token) async {
    final uri = Uri.parse(RemoteUrls.getWithdraw);
    print('get Withdraw $uri');
    final clientMethod = client.get(uri, headers: authHeader(token));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseJsonBody;
  }


  /// Add Withdraw
  @override
  Future addNewWithdraw(WithdrawStoreStateModel body, String token) async {
    final uri = Uri.parse(RemoteUrls.withdrawStore);
    print('Store Withdraw $uri');
    final clientMethod = client.post(uri,
        body: jsonEncode(body.toMap()), headers: authHeader(token));
    final responseJsonBody =
    await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }
}
