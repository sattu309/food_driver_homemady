import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../api_url/api_url.dart';
import '../models/driver_Information_model.dart';
import '../models/verify_otp_model.dart';


Future<DriverInformationModel> driverInformationRepo() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  log(user.authToken.toString());
  //log(respose.);
  http.Response response =
  await http.get(Uri.parse(ApiUrl.driverInformationUrl), headers: headers);
  log("<<<<<<<DriverInformation from repository=======>    ${response.body}");
  log("<<<<<<<DriverInformation from repository Url=======>     ${ApiUrl.driverInformationUrl}");
  if (response.statusCode == 200) {
    log("<<<<<<<DriverInformation from repository=======>${response.body}");
    return DriverInformationModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}