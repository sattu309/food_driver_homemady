import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homemady_drivers/models/common_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../api_url/api_url.dart';
import '../models/verify_otp_model.dart';
import '../widgets/new_helper.dart';

Future<ModelCommonResponse1> driverUpdateOrder(
    {required orderId, required status, required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['order_id'] = orderId;
  map['status'] = status;
  log(map.toString());
  OverlayEntry loader = NewHelper.overlayLoader(context);
  Overlay.of(context).insert(loader);
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  log(headers.toString());
  http.Response response = await http.post(Uri.parse(ApiUrl.driverOrderStatusUpdateUrl),
      body: jsonEncode(map), headers: headers);
  // print(response.body);
    NewHelper.hideLoader(loader);
  if (response.statusCode == 200 ||response.statusCode == 400) {
    return ModelCommonResponse1.fromJson(json.decode(response.body));
  } else {
    NewHelper.createSnackBar(context, response.body.toString());
    NewHelper.hideLoader(loader);
    throw Exception(response.body);
  }
}