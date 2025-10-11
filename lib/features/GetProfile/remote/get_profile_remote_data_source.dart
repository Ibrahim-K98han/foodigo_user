import 'dart:io';

import 'package:foodigo/data/network_parser.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/GetProfile/model/profile_state_model.dart';
import 'package:http/http.dart' as http;

abstract class GetProfileRemoteDataSource {
  Future getProfileData(String token);

  Future updateProfile(ProfileStateModel body, Uri uri, String token);
}

class GetProfileRemoteDataSourceImpl implements GetProfileRemoteDataSource {
  final http.Client client;

  GetProfileRemoteDataSourceImpl({required this.client});

  authHeader(String token) => {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
    // 'Accept': "x-www-form-urlencoded/application"
  };

  @override
  Future getProfileData(String token) async {
    final uri = Uri.parse(RemoteUrls.getProfile);
    // print('profile$uri');
    final clientMethod = client.get(uri, headers: authHeader(token));
    final responseJsonBody = await NetworkParser.callClientWithCatchException(
      () => clientMethod,
    );
    return responseJsonBody;
  }

  //update profile
  @override
  Future updateProfile(ProfileStateModel body, Uri uri, String token) async {
    final request = http.MultipartRequest('POST', uri);

    request.fields.addAll(
      body.toMap()
        ..remove('image')
        ..map((key, value) => MapEntry(key, value.toString())),
    );

    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
    if (body.image.isNotEmpty && File(body.image).existsSync()) {
      final file = await http.MultipartFile.fromPath('image', body.image);
      request.files.add(file);
    }
    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);
    final responseJsonBody = await NetworkParser.callClientWithCatchException(
      () => clientMethod,
    );
    return responseJsonBody['data']['user'];
  }
}
