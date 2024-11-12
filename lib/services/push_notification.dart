import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<dynamic> sendNotification({
  required msgTitle,
  required msgBody,
  required List<String> token,
}) async {
  if (kDebugMode) {
    print('token : $token');
  }

  final data = {
    "notification": {
      "body": "$msgBody",
      "title": "$msgTitle",
    },
    "android": {"priority": "high"},
    "priority": 10,
    "data": {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "1",
      "message": "chatMessage",
    },
    "registration_ids": token
  };
  final headers = {
    'content-type': 'application/json',
    'Authorization':
        'key=AAAAh-0TfHk:APA91bEQ30tQhrzQnPZI603nlQMke8Iyjt3Ne3b-mpTV87X6f_FKoJGQw3xjXpAlrQ5QXnR6sN3AHOAGKTVC_tMMOALWBVfhqKDPtTHu0iwxbGjhrSI9_Q1uaFLr_yBp_gAv3jbQq28l'
  };
  try {
    final response = await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"), body: jsonEncode(data), headers: headers);
    if (kDebugMode) {
      print("push notification response....     ${response.body}");
    }
    if (kDebugMode) {
      print(response.body);
    }
  } catch (e) {
    throw Exception(e);
  }
}
