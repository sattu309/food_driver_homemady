import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../api_url/api_url.dart';
import '../models/common_model.dart';
import '../models/verify_otp_model.dart';
import '../widgets/helper.dart';

Future<ModelCommonResponse> deliveryOtpVerify(
    {required orderId, required otp, required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['order_id'] = orderId;
  map['otp'] = otp;
  log(map.toString());
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  http.Response response = await http.post(Uri.parse(ApiUrl.deliveryVerifyOtpUrl),
      body: jsonEncode(map), headers: headers);
  // print(response.body);
  if (response.statusCode == 200 || response.statusCode == 400) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, response.body.toString());
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}

Future<ModelCommonResponse> resendDeliveryOtpVerify(
    {required orderId,required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['order_id'] = orderId;
  log(map.toString());
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  http.Response response = await http.post(Uri.parse(ApiUrl.resendDeliveryOtpUrl),
      body: jsonEncode(map), headers: headers);
  // print(response.body);
  if (response.statusCode == 200 || response.statusCode == 400) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, response.body.toString());
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}