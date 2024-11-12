import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:homemady_drivers/models/common_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../api_url/api_url.dart';
import '../models/verify_otp_model.dart';

Future<ModelCommonResponse> assignedOrder({
  required status, dynamic orderId,  context
}) async {
  Map<String, dynamic> map = {};
  map['order_id'] = orderId;
  map['status'] = status;
  SharedPreferences pref = await SharedPreferences.getInstance();

  log(map.toString());
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  try {
    final response =
    await http.post(Uri.parse(ApiUrl.assignedOrderListUrl), headers: headers,body: jsonEncode(map));
    log("${ApiUrl.assignedOrderListUrl}?status=$status");
    if (response.statusCode == 200) {
      log("AssignedOrder List Data...${response.body}");
      return ModelCommonResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}