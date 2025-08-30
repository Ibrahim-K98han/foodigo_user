import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:http/http.dart' as http;

abstract class ProductDetailsRemoteDataSource {
  Future getProductDetailsData(int id);
}

class ProductDetailsRemoteDataSourceImpl
    implements ProductDetailsRemoteDataSource {
  final http.Client client;

  ProductDetailsRemoteDataSourceImpl({required this.client});

  final contentHeader = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };

  @override
  Future getProductDetailsData(int id) async {
    final uri = Uri.parse(RemoteUrls.productDetailsData(id));
    print('Product====================$uri');
    final clientMethod = client.get(uri, headers: contentHeader);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }
}
