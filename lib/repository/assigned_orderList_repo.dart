import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../api_url/api_url.dart';
import '../models/assigned_orderList_model.dart';
import '../models/verify_otp_model.dart';

Future<assgnedOrderList> assignedOrderListRepo({
  required filterKeyword
}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  // try {
    final response =
    await http.get(Uri.parse("${ApiUrl.assignedOrderListUrl1}?status=$filterKeyword"), headers: headers);
    log("${ApiUrl.assignedOrderListUrl1}?status=$filterKeyword");
    if (response.statusCode == 200) {
      log("AssignedOrder List Data...${response.body}");
      return assgnedOrderList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  // } catch (e) {
  //   throw Exception(e.toString());
  // }
}