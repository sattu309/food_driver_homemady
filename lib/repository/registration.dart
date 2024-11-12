import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../api_url/api_url.dart';
import '../models/common_model.dart';
import '../models/verify_otp_model.dart';
import '../widgets/new_helper.dart';
Future<ModelCommonResponse> vendorRegistrationRepo({
  mapData,
  required fieldName1,
  required fieldName2,
  required fieldName3,
  required File file1,
  required File file2,
  required File file3,
  required context,
}) async {

  OverlayEntry loader = NewHelper.overlayLoader(context);
 Overlay.of(context).insert(loader);
    var request =
    http.MultipartRequest('POST', Uri.parse(ApiUrl.driverRegistrationApi));
    SharedPreferences pref = await SharedPreferences.getInstance();
    ModelVerifyOtp? user =
    ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
    };
    request.headers.addAll(headers);
    request.fields.addAll(mapData);

    if (file1.path != "" &&
        file2.path != "" && file3.path != "") {
      request.files.add(await multipartFile(fieldName1, file1));
      request.files.add(await multipartFile(fieldName2, file2));
      request.files.add(await multipartFile(fieldName3, file3));
    }

    log(request.fields.toString());
    log(request.files.map((e) => e.filename).toList().toString());
    final response = await request.send();
    final result=await response.stream.bytesToString();
    // log(result);
    if (response.statusCode == 200 || response.statusCode == 400) {
      NewHelper.hideLoader(loader);
      return ModelCommonResponse.fromJson(
          jsonDecode(result));
    } else {
      return ModelCommonResponse.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    }

}

Future<http.MultipartFile> multipartFile(String? fieldName, File file1) async {
  return http.MultipartFile(
    fieldName ?? 'file',
    http.ByteStream(Stream.castFrom(file1.openRead())),
    await file1.length(),
    filename: file1.path.split('/').last,
  );
}

