import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homemady_drivers/models/common_model.dart';
import 'package:http/http.dart' as http;

import '../api_url/api_url.dart';
import '../widgets/helper.dart';

Future<ModelCommonResponse> changePassword(
    email, password, confirmPassword, BuildContext context) async {
  var map = <String, dynamic>{};
  map['email'] = email;
  map['password'] = password;
  map['confirm_password'] = confirmPassword;

  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };
  // print(map);
  http.Response response = await http.post(Uri.parse(ApiUrl.resetPassword),
      body: jsonEncode(map), headers: headers);
  // print(response.body);
  if (response.statusCode == 200 || response.statusCode == 400) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse.fromJson(json.decode(response.body));
  } else {
    Helpers.hideLoader(loader);
    Helpers.createSnackBar(context, response.statusCode.toString());
    throw Exception(response.body);
  }
}

