import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:http/http.dart' as http;

abstract class GetAddressRemoteDataSource {
  Future getAllAddress(String token);

  Future deleteAddress(String token, String addressId);
}

class GetAddressRemoteDataSourceImpl implements GetAddressRemoteDataSource {
  final http.Client client;

  GetAddressRemoteDataSourceImpl({required this.client});

  Map<String, String> authHeader(String token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

  @override
  Future getAllAddress(String token) async {
    final uri = Uri.parse(RemoteUrls.getAddress);
    print('address $uri');

    final clientMethod = client.get(uri, headers: authHeader(token));

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future deleteAddress(String token, String addressId) async {
    // final uri = Uri.parse('${RemoteUrls.deleteAddress}/$addressId');
    final uri = Uri.parse(RemoteUrls.deleteAddress(addressId));
    print('delete address $uri');

    final clientMethod = client.delete(uri, headers: authHeader(token));

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }
}
