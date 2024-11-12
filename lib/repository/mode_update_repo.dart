import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../api_url/api_url.dart';
import '../models/mode_update_model.dart';
import '../models/verify_otp_model.dart';


Future<ModeUpdateModel> modeUpdate() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  // try {
  final response = await http.get(Uri.parse(ApiUrl.modeStatusUrl),
      headers: headers);
  log("Mode Status...${response.body}");

  if (response.statusCode == 200 ||response.statusCode == 400) {
    log("Mode Status Repository...${response.body}");
    return ModeUpdateModel.fromJson(jsonDecode(response.body));
  } else {
    return ModeUpdateModel.fromJson(jsonDecode(response.body));
  }
  // }
  // catch (e) {
  //   throw Exception(e.toString());
  // }
}