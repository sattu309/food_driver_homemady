import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../api_url/api_url.dart';
import '../models/vendor_bank_details.dart';
import '../models/verify_otp_model.dart';

Future<VendorBankDetailsModel> vendorBankDetailsRepo() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  try {
    final response = await http.get(Uri.parse(ApiUrl.vendorBankDetailsUrl),
        headers: headers);
    // print("Vendor Bank Details Repository...${response.body}");
    if (response.statusCode == 200) {
      // print("Vendor Bank Details Repository...${response.body}");
      return VendorBankDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}