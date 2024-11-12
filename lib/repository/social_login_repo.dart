import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import '../api_url/api_url.dart';
import '../models/social_login_model.dart';
import '../widgets/helper.dart';

Future<SocialLoginModel> socialLogin(
    {required String provider,required String token,
      required BuildContext context}) async {

  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);

  var map = <String, dynamic>{};
  map['provider'] = provider;
  map['token'] = token;
  var fcmToken = await FirebaseMessaging
      .instance
      .getToken();
  map['role'] = "3";
  map['device_token'] = fcmToken;

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  http.Response response = await http.post(Uri.parse(ApiUrl.socialUrl),
      body: jsonEncode(map), headers: headers);
  log(map.toString());
  log(response.statusCode.toString());
  log(response.body);
    Helpers.hideLoader(loader);
  if (response.statusCode == 200) {
    return SocialLoginModel.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, response.body.toString());
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}