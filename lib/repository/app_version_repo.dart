import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:homemady_drivers/models/app_version_model.dart';
import 'package:http/http.dart' as http;

Future<ModelAppVersion> getUpdateVersion({versioncode, type}) async {
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  }; // log(user.authToken.toString());
  http.Response response =
  await http.get(Uri.parse("http://52.50.121.179/api/driver-get-app-version?driver_app_version=$versioncode&type=$type"), headers: headers);
  log("<<<<<<<PrivacyPolicyData=======>${response.body}");
  if (response.statusCode == 200) {
    log("<<<<<<<PrivacyPolicyData=======>${response.body}");
    return ModelAppVersion.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}


