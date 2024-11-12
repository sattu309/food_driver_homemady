import 'dart:developer';
import 'dart:io';
import 'package:homemady_drivers/models/common_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../api_url/api_url.dart';
import '../models/verify_otp_model.dart';

Future<ModelCommonResponse> mailToAdminRepo() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  // try {
  final response = await http.get(Uri.parse(ApiUrl.mailToAdminUrl),
      headers: headers);
  log("Mail Request to admin Repository....${response.body}");

  if (response.statusCode == 200) {
    log("Mail Request to admin Repository...${response.body}");
    return ModelCommonResponse.fromJson(jsonDecode(response.body));
  } else {
    return ModelCommonResponse.fromJson(jsonDecode(response.body));
  }
  // }
  // catch (e) {
  //   throw Exception(e.toString());
  // }
}