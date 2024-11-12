import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../api_url/api_url.dart';
import '../models/privacy_policy.dart';
import '../models/verify_otp_model.dart';

Future<PrivacyPolicyModel> privacyPolicyData({required slug}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  log(user.authToken.toString());
  http.Response response =
  await http.get(Uri.parse('${ApiUrl.privacyPolicyUrl}?slug=privacy-policy'), headers: headers);
  log("<<<<<<<PrivacyPolicyData=======>${response.body}");
  if (response.statusCode == 200) {
    log("<<<<<<<PrivacyPolicyData=======>${response.body}");
    return PrivacyPolicyModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}