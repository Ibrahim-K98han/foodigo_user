import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:http/http.dart' as http;

abstract class PrivacyPolicyRemoteDataSource {
  Future getPrivacyPolicy(String langCode);
  Future getTermsAndCondition(String langCode);
  Future getOfferAndReward(String langCode);
}

typedef CallClientMethod = Future<http.Response> Function();

class PrivacyPolicyRemoteDataSourceImpl extends PrivacyPolicyRemoteDataSource {
  final http.Client client;

  PrivacyPolicyRemoteDataSourceImpl({required this.client});

  final headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };

  final postDeleteHeader = {
    'Accept': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };

  @override
  Future getPrivacyPolicy(String langCode) async {
    final uri = Uri.parse(
      RemoteUrls.privacyPolicy,
    ).replace(queryParameters: {'lang_code': langCode});
    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody = await NetworkParser.callClientWithCatchException(
      () => clientMethod,
    );
    return responseJsonBody;
  }

  @override
  Future getTermsAndCondition(String langCode) async {
    final uri = Uri.parse(
      RemoteUrls.termsAndCondition,
    ).replace(queryParameters: {'lang_code': langCode});
    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody = await NetworkParser.callClientWithCatchException(
      () => clientMethod,
    );
    return responseJsonBody;
  }

  @override
  Future getOfferAndReward(String langCode) async {
    final uri = Uri.parse(
      RemoteUrls.offerAndReward,
    ).replace(queryParameters: {'lang_code': langCode});
    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody = await NetworkParser.callClientWithCatchException(
      () => clientMethod,
    );
    return responseJsonBody;
  }
}
