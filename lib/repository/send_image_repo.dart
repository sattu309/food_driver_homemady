import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../api_url/api_url.dart';
import '../models/chat_model/chat_image_model.dart';
import '../models/verify_otp_model.dart';


Future<ChatImageModal> sendImage(
    {
      required fieldName1,
      required File file1}) async {
  try {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiUrl.sendImageUrl));
    SharedPreferences pref = await SharedPreferences.getInstance();
    ModelVerifyOtp? user = ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
    };
    request.headers.addAll(headers);

    //request.fields.addAll(mapData);

    if (file1.path != "") {
      log(file1.path);
      log("99999999999999999999");
      request.files.add(await multipartFile(fieldName1, file1));
    }

    log(request.fields.toString());
    log(request.files.map((e) => e.filename).toList().toString());
    final response = await request.send();
    String apiResponse = await response.stream.bytesToString();
    log("apiResponse........    $apiResponse");
    log("apiResponse........    ${request.fields.toString()}");

    if (response.statusCode == 200 || response.statusCode == 400) {

      return ChatImageModal.fromJson(jsonDecode(apiResponse));
    } else {
      return ChatImageModal.fromJson(jsonDecode(apiResponse));
    }
  } on SocketException {
    return ChatImageModal(status: true);
  } catch (e) {
    return ChatImageModal(status: true);
  }
}

Future<http.MultipartFile> multipartFile(String? fieldName, File file1) async {
  return http.MultipartFile(
    fieldName ?? "file_data",
    http.ByteStream(Stream.castFrom(file1.openRead())),
    await file1.length(),
    filename: file1.path.split('/').last,
  );
}
