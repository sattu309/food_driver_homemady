// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;
// import '../api_url/api_url.dart';
// import '../models/get_update _version.dart';
//
// Future<GetUpdateModel> getUpdateVersion({driver_app_version,type}) async {
//
//   // try {
//   http.Response response = await http.get(Uri.parse("http://52.50.121.179/api/driver-get-app-version?driver_app_version=$driver_app_version&type=$type"),
//       headers: await getAuthHeader());
//   log("verify IN DATA${response.body}");
//   // http.Response response = await http.post(Uri.parse(ApiUrls.loginUser),
//   //     headers: await getAuthHeader(),body: jsonEncode(map) );
//
//   if (response.statusCode == 200) {
//     // Helpers.hideLoader(loader);
//     print(jsonDecode(response.body));
//     return GetUpdateModel.fromJson(jsonDecode(response.body));
//   } else {
//     // Helpers.hideLoader(loader);
//     print(jsonDecode(response.body));
//     return GetUpdateModel(
//       message: jsonDecode(response.body)["message"],
//     );
//   }
//   // }  catch (e) {
//   //   Helpers.hideLoader(loader);
//   //   return ModelCommonResponse(message: e.toString(), success: false);
// }
