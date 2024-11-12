import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_theme.dart';

class Helpers {
  /// Auth Services

  late BuildContext context;
  late DateTime currentBackPressTime;
  late String savedLanguage;

  Helpers.of(BuildContext _context) {
    context = _context;
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }

  String convertToBase64(String credentials) {
    final Codec<String, String> stringToBase64 = utf8.fuse(base64);
    return stringToBase64.encode(credentials);
  }

  String base64ToString(String credentials) {
    final Codec<String, String> base64ToString = utf8.fuse(base64);
    return base64ToString.decode(credentials);
  }

  static OverlayEntry overlayLoader(context) {
    OverlayEntry loader = OverlayEntry(builder: (context) {
      final size = MediaQuery
          .of(context)
          .size;
      return Positioned(
        height: size.height,
        width: size.width,
        top: 0,
        left: 0,
        child: Material(
          color: AppTheme.primaryColor.withOpacity(0.02),
//color:  Color(0xFF7ED957),
          child: const CupertinoActivityIndicator(
            radius: 30,
          ),
        ),
      );
    });
    return loader;
  }

  static hideLoader(OverlayEntry loader) {
    Timer(const Duration(milliseconds: 500), () {
      try {
        loader.remove();
        // ignore: empty_catches
      } catch (e) {}
    });
  }

  static hideShimmer(OverlayEntry loader) {
    Timer(const Duration(milliseconds: 500), () {
      try {
        loader.remove();
        // ignore: empty_catches
      } catch (e) {}
    });
  }

  static Uri getUri(String baseUrl, String path) {
    String path = Uri.parse(baseUrl).path;
    if (!path.endsWith('/')) {
      path += '/';
    }
    Uri uri = Uri(
        scheme: Uri.parse(baseUrl).scheme,
        host: Uri.parse(baseUrl).host,
        port: Uri.parse(baseUrl)
            .port, //GlobalConfiguration().getValue('base_url')
        path: path + path);
    return uri;
  }

  /*static Future<bool> verifyInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }*/
  static String discount(int price, int saleprice) {
    try {
      // var intprice = int.parse(price);
      //  var intsaleprice = int.parse(saleprice);
      double par = ((price - saleprice) / price) * 100;
      double i = double.parse((par).toStringAsFixed(2));
      return '$i';
    } catch (e) {
      return '';
    }
  }

  static createSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.black,
      content: Text(
        message,
        style: const TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.white),
      ),
    ));
  }

  Future<List<File>?> addFilePickerList() async {
    try {
      final item = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg'],
      );
      if (item == null) {
        return null;
      } else {
        return item.files.map((e) => File(e.path!)).toList();
      }
    } on PlatformException catch (e) {
      throw Exception(e);
    }
  }

  static bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return (!regex.hasMatch(value)) ? false : true;
  }
}
String? validateMobile(String? value) {
  if (value!.length != 10) {
    return 'Enter Mobile Number & must be of 10 digit';
  } else {
    return null;
  }
}

String? validateName(String? name) {
  if (name!.isEmpty) {
    return 'Please Enter Name';
  } else {
    return null;
  }
}

String? validateEmail(String? email) {
  if (email!.isEmpty) {
    return 'Please Enter Email';
  } else {
    return null;
  }
}

extension DateComparision on DateTime{

  bool get isCurrentData{
    final DateTime currentTime = DateTime.now();
    final DateTime todayDate = DateTime(currentTime.year,currentTime.month,currentTime.day);
    return todayDate.isAtSameMomentAs(DateTime(year,month,day));
  }

  DateTime get toSimpleDate{
    // final DateTime currentTime = DateTime.now();
    // final DateTime todayDate = DateTime(currentTime.year,currentTime.month,currentTime.day);
    return DateTime(year,month,day);
  }

}