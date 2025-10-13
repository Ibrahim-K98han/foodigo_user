import 'package:foodigo/features/ForgotPassword/cubit/forgot_password_state_model.dart';
import 'package:http/http.dart' as http;

import '../../../data/network_parser.dart';
import '../../../data/remote_url.dart';
import '../cubit/forgot_password_verify_state_model.dart';

abstract class ForgotPasswordVerifyRemoteDataSource {
  Future forgotPassOtpVerify(ForgotPasswordVerifyStateModel body);
}

class ForgotPasswordVerifyRemoteDataSourceImpl
    extends ForgotPasswordVerifyRemoteDataSource {
  final http.Client client;

  ForgotPasswordVerifyRemoteDataSourceImpl({required this.client});

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
  Future forgotPassOtpVerify(ForgotPasswordVerifyStateModel body) async {
    final uri = Uri.parse(
      RemoteUrls.forgotPassOtpVerify,
    ).replace(queryParameters: {'lang_code': body.languageCode});
    print('forgot pass verify otp: $uri');
    final clientMethod = client.post(
      uri,
      body: body.toMap(),
      headers: postDeleteHeader,
    );
    final responseJsonBody = await NetworkParser.callClientWithCatchException(
      () => clientMethod,
    );
    return responseJsonBody;
  }
}
