import 'package:foodigo/features/ForgotPassword/cubit/forgot_password_state_model.dart';
import 'package:http/http.dart' as http;

import '../../../data/network_parser.dart';
import '../../../data/remote_url.dart';

abstract class ForgotPasswordRemoteDataSource {
  Future<String> forgotPassword(Map<String, dynamic> body);

  Future<String> resetPassword(
    ForgotPasswordStateModel body,
  );

  Future forgotOtpVerify(ForgotPasswordStateModel body, String email);
  Future forgotPassOtpVerify(ForgotPasswordStateModel body);
}

class ForgotPasswordRemoteDataSourceImpl
    extends ForgotPasswordRemoteDataSource {
  final http.Client client;

  ForgotPasswordRemoteDataSourceImpl({required this.client});

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
  Future<String> forgotPassword(Map<String, dynamic> body) async {
    final uri = Uri.parse(RemoteUrls.forgotPassword);
    final clientMethod = client.post(
      uri,
      headers: postDeleteHeader,
      body: body,
    );
    final responseJsonBody = await NetworkParser.callClientWithCatchException(
      () => clientMethod,
    );
    return responseJsonBody['message'] as String;
  }

  @override
  Future<String> resetPassword(
    ForgotPasswordStateModel body,
  ) async {
    final uri = Uri.parse(RemoteUrls.resetPassword);
    print('update-password-url $uri');
    final clientMethod = client.post(
      uri,
      headers: postDeleteHeader,
      body: body.toMap(),
    );
    final responseJsonBody = await NetworkParser.callClientWithCatchException(
      () => clientMethod,
    );
    return responseJsonBody['message'] as String;
  }

  @override
  Future forgotOtpVerify(ForgotPasswordStateModel body, String email) async {
    final uri = Uri.parse(RemoteUrls.otpVerify);
    print("Otp url : $uri");

    final clientMethod = client.post(
      uri,
      headers: {
        'Accept': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
      },
      body: {"email": email, "otp": body.otp},
    );
    print("Sending OTP: '${body.otp}'");

    final responseJsonBody = await NetworkParser.callClientWithCatchException(
      () => clientMethod,
    );

    print("[RemoteDataSourceImpl] $responseJsonBody");
    return responseJsonBody['message'];
  }

  @override
  Future forgotPassOtpVerify(ForgotPasswordStateModel body) async{
    final uri = Uri.parse(RemoteUrls.forgotPassOtpVerify).replace(queryParameters: {'lang_code':body.languageCode});
    print('forgot pass verify otp: $uri');
    final clientMethod =
    client.post(uri, body: body.toMap(), headers: postDeleteHeader);
    final responseJsonBody =
    await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;

  }
}
