import 'dart:async';
import 'dart:developer';
import 'package:client_information/client_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/user_profile_repo.dart';
import '../routers/routers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  checkUser() async {

    SharedPreferences pref = await SharedPreferences.getInstance();

    if (pref.getString('user_info') != null) {
      userProfileData().then((value){
        if(value.data!.asDriverVerified==true){
          Get.offAllNamed(MyRouters.dashbordScreen);
          return;
        }
        // else if(value.data!.isVendor==true){
        //   Get.offAllNamed(ThankYouVendorScreen.thankYouVendorScreen);
        // }
        else{
          Get.offAllNamed(MyRouters.deliveryPartnerApplyScreen);
          return;
        }
      });
    }
    else{
      Get.offAllNamed(MyRouters.onBoardingScreen);
      return;
    }
  }

  Future<void> _getClientInformation() async {
    ClientInformation? info;
    try {
      info = await ClientInformation.fetch();
    } on PlatformException {
      log('Failed to get client information');
    }
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('deviceId', info!.deviceId.toString());
  }


  @override
  void initState() {
    super.initState();
    _getClientInformation();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      checkUser();
    });
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Timer(const Duration(seconds: 2), () async {
  //     SharedPreferences pref = await SharedPreferences.getInstance();
  //     if (pref.getString('user_info') != null) {
  //       UserProfileModel? user = UserProfileModel.fromJson(jsonDecode(pref.getString('user_info')!));
  //       if(user.data!.asDriverVerified == true){
  //         Get.offAllNamed(MyRouters.dashbordScreen);
  //         return;
  //       }
  //      else{
  //         Get.offAllNamed(MyRouters.deliveryPartnerApplyScreen);
  //         return;
  //       }
  //     }
  //     else{
  //       Get.offAllNamed(MyRouters.onBoardingScreen);
  //     }
  //   }
  //
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Image.asset('assets/images/Splash2.png',
            fit: BoxFit.fill,),
        ));
  }

}

