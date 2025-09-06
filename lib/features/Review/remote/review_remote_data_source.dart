import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:http/http.dart' as http;

abstract class ReviewRemoteDataSource {
  Future getReview(String token);

// Future addToWishList(String token, int productId);
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final http.Client client;

  ReviewRemoteDataSourceImpl({required this.client});

  authHeader(String token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        // 'Accept': "x-www-form-urlencoded/application"
      };


  ///Show Review
  @override
  Future getReview(String token) async {
    final uri = Uri.parse(RemoteUrls.getReview);
    print('Review====$uri');
    final clientMethod = client.get(uri, headers: authHeader(token));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  ///Add Review
// @override
// Future addToWishList(String token, int productId) async {
//   final uri = Uri.parse(RemoteUrls.addWishList); // Add your endpoint here
//   print('AddWishList====$uri');
//
//   final body = {'product_id': productId};
//
//   final clientMethod =
//       client.post(uri, headers: authHeader(token), body: jsonEncode(body));
//
//   final responseJsonBody =
//       await NetworkParser.callClientWithCatchException(() => clientMethod);
//
//   return responseJsonBody;
// }
}
