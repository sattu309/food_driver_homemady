import 'dart:io'as io;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homemady_drivers/routers/routers.dart';
import 'package:salesiq_mobilisten/launcher.dart';
import 'package:salesiq_mobilisten/salesiq_mobilisten.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/custome_size.dart';
import '../widgets/custome_textfiled.dart';


class Help_Center_Screen extends StatefulWidget {
  const Help_Center_Screen({Key? key}) : super(key: key);

  @override
  State<Help_Center_Screen> createState() => _Help_Center_ScreenState();
}

class _Help_Center_ScreenState extends State<Help_Center_Screen> {
  void sendEmail() async {
    // Change the email address and subject to suit your needs
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'support@homemady.com',
      query: 'subject=Hello%20from%20Flutter',
    );

    // if (await canLaunch(params.toString())) {
      await launch(params.toString());
    // } else {
    //   throw 'Could not launch email';
    // }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: backAppBar(title: 'Help Center', context: context),
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
        child: Column(
          children: [
            InkWell(
              onTap: (){
                  // mailToAdminRepo().then((value){
                  //   if(value.status==true){
                  //     NewHelper.showToast(value.message);
                  //   }
                  // });
                sendEmail();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF37C666).withOpacity(0.10),
                      offset: const Offset(
                        .1,
                        .1,
                      ),
                      blurRadius: 20.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/helpMsg.png',
                      width: 52,
                      height:40,
                    ),
                   const SizedBox(width: 20,),
                    const Expanded(
                     child:  Text("Email HomeMady Support",
                       style:TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 19,
                          color: Color(0xFF1A2E33)
                      ),),
                   ),
                  ],
                ),
              ),
            ),
            addHeight(15),
            InkWell(
              onTap: (){

                if (io.Platform.isIOS || io.Platform.isAndroid) {
                  String appKey;
                  String accessKey;
                  if (io.Platform.isIOS) {
                    appKey = "CXSxB2zDTR89fuCKLrSRhlmyW%2BlNxo8fxcbc%2BKh6Vxp9EoV6IOZ8rxCiGj66ic5Z";
                    accessKey = "czr96nQAmUTLRIC0OSM5kKdn%2FSzhx%2B%2BWOhGmYQwAR6aiRn43iVGzXoniMJ5b7twOVMrP5blDbG8PEzwyOBUYTJi9oQZu%2BAbUtaJnG9om%2F6m%2B0Ehj7oJEbw%3D%3D";
                  } else {
                    appKey = "CXSxB2zDTR89fuCKLrSRhlmyW%2BlNxo8fxcbc%2BKh6Vxp9EoV6IOZ8rxCiGj66ic5Z";
                    accessKey = "czr96nQAmUQn%2BokFyAG44uJleP9iI%2BfTaViO7Dl%2FhnwUEGtFny%2BCUGMVcpeLfBpPG9a8iPkrxmOdLMuKsNwi0xXIbE75QltyifB2nH4Wx0DJ%2FCW7Txu7tIF5ADvpsthLezxSsg0I9S8%3D";
                  }
                  ZohoSalesIQ.init(appKey, accessKey).then((_) {
                    // initialization successful
                    ZohoSalesIQ.launcher.show(VisibilityMode.never);
                    ZohoSalesIQ.openNewChat();
                    // To show the default live chat launcher, you can use the launcher.show API.
                    // Alternatively, you may use the 'Avail floating chat button for your app' option under Settings → Brands → Installation → Android/iOS.
                  }).catchError((error) {
                    // initialization failed
                    print(error);
                  });
                }


              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF37C666).withOpacity(0.10),
                      offset: const Offset(
                        .1,
                        .1,
                      ),
                      blurRadius: 20.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/headphone.png',
                      width: 52,
                      height:40,
                    ),
                    const SizedBox(width: 20,),
                    const Expanded(
                      child: Text("Chat HomeMady Support",
                        style:TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 19,
                            color: Color(0xFF1A2E33)
                        ),),
                    ),
                  ],
                ),
              ),
            ),
            addHeight(15),
            GestureDetector(
              onTap: (){
                Get.toNamed(MyRouters.faqsScreen);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF37C666).withOpacity(0.10),
                      offset: const Offset(
                        .1,
                        .1,
                      ),
                      blurRadius: 20.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/faq.png',
                      width: 52,
                      height:40,
                    ),
                   const SizedBox(width: 20,),
                   const Text("FAQ",
                      style:TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Color(0xFF1A2E33)
                      ),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
