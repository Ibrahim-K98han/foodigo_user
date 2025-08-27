import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:http/http.dart' as http;

abstract class SingleRestaurantRemoteDataSource {
  Future getSingleRestaurant(String slug);
}

class SingleRestaurantRemoteDataSourceImpl
    implements SingleRestaurantRemoteDataSource {
  final http.Client client;

  SingleRestaurantRemoteDataSourceImpl({required this.client});

  final contentHeader = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };

  @override
  Future getSingleRestaurant(String slug) async {
    final uri = Uri.parse(RemoteUrls.singleRestaurantsData(slug));
    print('restaurant$uri');
    final clientMethod = client.get(uri, headers: contentHeader);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }
}
