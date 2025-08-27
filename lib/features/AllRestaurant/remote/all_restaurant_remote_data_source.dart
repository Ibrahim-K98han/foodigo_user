import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:http/http.dart' as http;

abstract class AllRestaurantRemoteDataSource {
  Future getAllRestaurant();
}

class AllRestaurantRemoteDataSourceImpl
    implements AllRestaurantRemoteDataSource {
  final http.Client client;

  AllRestaurantRemoteDataSourceImpl({required this.client});

  final contentHeader = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };

  @override
  Future getAllRestaurant() async {
    final uri = Uri.parse(RemoteUrls.restaurantsData);
    print('restaurant$uri');
    final clientMethod = client.get(uri, headers: contentHeader);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }
}
