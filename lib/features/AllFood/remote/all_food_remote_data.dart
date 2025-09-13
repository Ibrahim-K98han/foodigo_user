import 'package:foodigo/data/network_parser.dart';
import 'package:http/http.dart' as http;

import '../../../data/remote_url.dart';

abstract class AllFoodRemoteDataSource {
  Future getAllFood(Uri uri);
}

class AllFoodRemoteDataSourceImpl implements AllFoodRemoteDataSource {
  final http.Client client;

  AllFoodRemoteDataSourceImpl({required this.client});

  final contentHeader = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };

  @override
  Future getAllFood(Uri uri) async {

    final clientMethod = client.get(uri, headers: contentHeader);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }
}
