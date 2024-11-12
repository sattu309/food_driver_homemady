import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../api_url/api_url.dart';
import '../models/verify_otp_model.dart';
import '../routers/routers.dart';
import '../widgets/new_helper.dart';

Future<ModelVerifyOtp> loginRepo(
    {required String email,
      required String password,
      required String role,
      required String fcmToken,
      required BuildContext context}) async {
  
  OverlayEntry loader = NewHelper.overlayLoader(context);
  Overlay.of(context).insert(loader);
  SharedPreferences pref = await SharedPreferences.getInstance();
  //// print("These are details.....${pref}");
  var map = <String, dynamic>{};
  map['email_number'] = email;
  map['password'] = password;
  map['role'] = "3";
  map['device_id'] = pref.getString("deviceId");
  map['device_token'] = fcmToken;

  log("Login Data map$map");
  try {
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };

    http.Response response = await http.post(Uri.parse(ApiUrl.loginApi),
        body: jsonEncode(map), headers: headers);

    log("<<<<<<<Login Data from repository=======>${response.body}");

    if (response.statusCode == 200||response.statusCode == 400) {
      NewHelper.hideLoader(loader);
      return ModelVerifyOtp.fromJson(json.decode(response.body));
    }    else if(response.statusCode == 401){
      Get.offAllNamed(MyRouters.loginScreen);
      throw Exception(response.body);
    }
    else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
