import 'dart:convert';

import 'package:foodigo/features/ForgotPassword/cubit/forgot_password_state_model.dart';
import 'package:http/http.dart' as http;

import '../../../data/network_parser.dart';
import '../../../data/remote_url.dart';

abstract class ForgotPasswordRemoteDataSource {
  Future<String> forgotPassword(Map<String, dynamic> body);

  Future<String> resetPassword(
      ForgotPasswordStateModel body, String email, String otp);

  Future otpVerify(ForgotPasswordStateModel body, String email);
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
    final clientMethod =
        client.post(uri, headers: postDeleteHeader, body: body);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future<String> resetPassword(
      ForgotPasswordStateModel body, String email, String otp) async {
    final uri = Uri.parse(RemoteUrls.resetPassword);
    print('update-password-url $uri');
    final clientMethod =
        client.post(uri, headers: postDeleteHeader, body: body.toMap());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future otpVerify(ForgotPasswordStateModel body, String email) async {
    final uri = Uri.parse(RemoteUrls.otpVerify);
    print("Otp url : $uri");

    final Map<String, dynamic> requestBody = {
      "email": email,
      "otp": body.otp, // make sure this contains the OTP entered by user
    };

    final clientMethod = client.post(
      uri,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json', // important!
        'X-Requested-With': 'XMLHttpRequest',
      },
      body: jsonEncode(requestBody),
    );

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseJsonBody;
  }
}
