import 'dart:convert';
import 'package:http/http.dart' as http;

import '../api_url/api_url.dart';
import '../models/faq_model.dart';




Future<faqScreen> faqRepo({required type}) async {
  try {
    http.Response response = await http.get(
      Uri.parse('${ApiUrl.faq}?type=$type'),

    );
    // print(response.body);
    if (response.statusCode == 200) {
      // print(jsonDecode(response.body));
      return faqScreen.fromJson(jsonDecode(response.body));

    } else {

      return faqScreen(
      );
    }
  } catch (e) {
    return faqScreen();
  }
}