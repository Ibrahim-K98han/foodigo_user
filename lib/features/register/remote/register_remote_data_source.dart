import '../../../data/network_parser.dart';
import '../../../data/remote_url.dart';
import '../model/register_state_model.dart';
import 'package:http/http.dart' as http;

abstract class RegisterRemoteDataSource {
  Future register(RegisterStateModel body);

  Future otpVerify(RegisterStateModel body, String email);

  Future<String> resendVerificationCode(Map<String, dynamic> body);
}

class RegisterRemoteDataSourceImpl extends RegisterRemoteDataSource {
  final http.Client client;

  RegisterRemoteDataSourceImpl({required this.client});

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
  Future register(RegisterStateModel body) async {
    final uri = Uri.parse(RemoteUrls.register);
    print("register url : $uri");
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
  Future otpVerify(RegisterStateModel body, String email) async {
    final uri = Uri.parse(RemoteUrls.otpVerify);
    print("Otp url : $uri");
    final clientMethod =
        client.post(uri, body: body.toMap(), headers: postDeleteHeader);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future<String> resendVerificationCode(Map<String, dynamic> body) async {
    final uri = Uri.parse(RemoteUrls.resendVerificationCode);

    final clientMethod =
        client.post(uri, headers: postDeleteHeader, body: body);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future<String> forgotPassword(Map<String, dynamic> body) async {
    final uri = Uri.parse(RemoteUrls.forgotPassword);
    final clientMethod =
        client.post(uri, headers: postDeleteHeader, body: body);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }
}
