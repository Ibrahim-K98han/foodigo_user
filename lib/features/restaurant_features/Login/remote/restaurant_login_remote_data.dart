import '../../../../data/network_parser.dart';
import '../../../../data/remote_url.dart';
import '../model/restaurant_login_state_model.dart';
import 'package:http/http.dart' as http;

abstract class RestaurantLoginRemoteData {
  Future restaurantLogin(RestaurantLoginStateModel body);

  Future restaurantLogout(Uri uri, String token);
}

class RestaurantLoginRemoteDataImpl implements RestaurantLoginRemoteData {
  final http.Client client;

  RestaurantLoginRemoteDataImpl({required this.client});

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
  Future restaurantLogin(RestaurantLoginStateModel body) async {
    final uri = Uri.parse(RemoteUrls.restaurantLogin);
    print("restaurant login url : $uri");

    final clientMethod = client.post(
      uri,
      body: body.toMap(),
      headers: postDeleteHeader,
    );
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseJsonBody;
  }

  @override
  Future restaurantLogout(Uri uri, String token) async {
    final clientMethod = client.post(uri, headers: authHeader(token));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }
}
