import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../api_url/api_url.dart';
import '../models/verify_otp_model.dart';
import '../models/withdraw_money_controller.dart';

Future<WithdrawalListModel> myWithdrawalListRepo() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  try {
    final response =
    await http.get(Uri.parse(ApiUrl.withdrawalListUrl), headers: headers);
    // print("Withdrawal List Repository...${response.body}");

    if (response.statusCode == 200) {
      // print("Withdrawal List Repository...${response.body}");
      return WithdrawalListModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}