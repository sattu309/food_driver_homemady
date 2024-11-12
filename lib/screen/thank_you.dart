import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homemady_drivers/routers/routers.dart';
import '../widgets/app_assets.dart';
import '../widgets/custome_textfiled.dart';
import '../widgets/dimenestion.dart';

class ThankYouVendorScreen extends StatefulWidget {
  const ThankYouVendorScreen({Key? key}) : super(key: key);
  static var thankYouVendorScreen = "/thankYouVendorScreen";
  @override
  State<ThankYouVendorScreen> createState() => _ThankYouVendorScreenState();
}

class _ThankYouVendorScreenState extends State<ThankYouVendorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AddSize.padding16, vertical: AddSize.padding16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: AddSize.size20 * 6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Image(
                height: AddSize.size300,
                width: double.maxFinite,
                image: const AssetImage(AppAssets.tq),
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
           const Text(
              "Your Account Has Been\n Successfully Created",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 28,
                  color:  Color(0xff262F33)),
            ),
           const SizedBox(
              height: 15,
            ),
           // const Text(
           //    "Admin Will Verify and Update You by\nCall or Email",
           //    textAlign: TextAlign.center,
           //    style: TextStyle(
           //        fontWeight: FontWeight.w300,
           //        fontSize: 14,
           //        color: Color(0xFF596774)),
           //  ),
            SizedBox(
              height: AddSize.size10,
            ),
          ],
        ),
      )),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AddSize.padding16, vertical: AddSize.size40),
        child:
        CommonButton(
          title: 'Continue',
          onPressed: () {
            Get.offAllNamed(MyRouters.dashbordScreen);
          },
        )
      ),
    );
  }
}
