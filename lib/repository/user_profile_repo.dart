import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../api_url/api_url.dart';
import '../models/user_profile_model.dart';
import '../models/verify_otp_model.dart';
import '../routers/routers.dart';

Future<UserProfileModel> userProfileData() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  log(user.authToken.toString());
  http.Response response =
  await http.get(Uri.parse(ApiUrl.userProfileUrl), headers: headers);
  log("<<<<<<<UserProfileData=======>${response.body}");
  if (response.statusCode == 200 ) {
    log("<<<<<<<UserProfileData=======>${response.body}");
    return UserProfileModel.fromJson(json.decode(response.body));
  }    else if(response.statusCode == 401){
    Get.offAllNamed(MyRouters.loginScreen);
    throw Exception(response.body);
  }
  else {
    throw Exception(response.body);
  }
}