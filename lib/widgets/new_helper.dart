import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'app_theme.dart';

class NewHelper {

  Future<File?> getGalleryImage() async {
    final picker=ImagePicker();
    try{
      final pickedImage= await picker.pickImage(source: ImageSource.gallery);
      if(pickedImage != null){
        return File(pickedImage.path);
      }
      else{
        return null;
      }

    }catch(error){
      print("$error");
    }
  }
  Future addFilePicker() async {
    try {
      final item = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['jpg','png','jpeg'],);
      if (item == null) {
        return null;
      } else {
        return File(item.files.first.path!);
      }
    } on PlatformException catch (e) {
      throw Exception(e);
    }
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

  Future<File?> addImagePicker(
      {ImageSource imageSource = ImageSource.gallery,
        int imageQuality = 50}) async {
    try {
      final item = await ImagePicker()
          .pickImage(source: imageSource, imageQuality: imageQuality);
      if (item == null) {
        return null;
      } else {
        return File(item.path);
      }
    } on PlatformException catch (e) {
      throw Exception(e);
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
  static hideLoader(OverlayEntry loader) {
    Timer(const Duration(milliseconds: 250), () {
      try {
        loader.remove();
        // ignore: empty_catches
      } catch (e) {}
    });
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
  static showToast(message) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,

        // const Color(0xFF7ED957),
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
Future<File?> getGalleryImage() async {
  final picker=ImagePicker();
  try{
    final pickedImage= await picker.pickImage(source: ImageSource.gallery);
    if(pickedImage != null){
      return File(pickedImage.path);
    }
    else{
      return null;
    }

  }catch(error){
    print("$error");
  }
}
