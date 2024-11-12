import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../api_url/api_url.dart';
import '../models/bank_list_model.dart';
import '../models/verify_otp_model.dart';

Future<VendorBankListModel> vendorBankListRepo() async {
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
    await http.get(Uri.parse(ApiUrl.vendorBankListUrl), headers: headers);
    // print("Vendor Bank List Repository...${response.body}");
    if (response.statusCode == 200) {
      // print("Vendor Bank List Repository...${response.body}");
      return VendorBankListModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}