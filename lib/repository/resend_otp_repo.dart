import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api_url/api_url.dart';
import '../models/resend_otp_model.dart';
import '../widgets/new_helper.dart';


Future<ResendOtpModel> resendOtpRepo(
    {required String email,
      required String roleText,
      required BuildContext context}) async {
  OverlayEntry loader = NewHelper.overlayLoader(context);
  Overlay.of(context).insert(loader);
  SharedPreferences pref = await SharedPreferences.getInstance();
  //// print("These are details.....${pref}");
  var map = <String, dynamic>{};
  map['email'] = email;
  map['role'] = roleText;
  // map['device_token'] = fcmToken;

  //log("Login Data map$map");
  try {
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };

    http.Response response = await http.post(Uri.parse(ApiUrl.resendOtpUrl),
        body: jsonEncode(map), headers: headers);

    if (response.statusCode == 200||response.statusCode == 400) {
      // print("<<<<<<<Resend otp  Data from repository=======>${response.body}");
      NewHelper.hideLoader(loader);
      return ResendOtpModel.fromJson(json.decode(response.body));
    } else {
      NewHelper.hideLoader(loader);
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}