import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homemady_drivers/routers/routers.dart';
import '../widgets/app_assets.dart';
import '../widgets/app_theme.dart';
import '../widgets/dimenestion.dart';

class DeliveredSuccessfullyScreen extends StatefulWidget {
  const DeliveredSuccessfullyScreen({Key? key}) : super(key: key);
  static var deliveredSuccessfullyScreen = "/deliveredSuccessfullyScreen";
  @override
  State<DeliveredSuccessfullyScreen> createState() =>
      _DeliveredSuccessfullyScreenState();
}

class _DeliveredSuccessfullyScreenState
    extends State<DeliveredSuccessfullyScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
                  height: AddSize.size30 * 2.5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Image(
                    height: AddSize.size300,
                    width: double.maxFinite,
                    image: const AssetImage(AppAssets.thankYou),
                    fit: BoxFit.contain,
                    color: const Color(0xff7ED957),
                  ),
                ),
                SizedBox(
                  height: AddSize.size40,
                ),
                Text(
                  "Order delivered successfully",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 28,
                      color: AppTheme.blackcolor),
                ),
              ],
            ),
          )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.offAndToNamed(MyRouters.dashbordScreen);
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.maxFinite, 60), backgroundColor: AppTheme.primaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AddSize.size10)),
                    textStyle: TextStyle(
                        fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                child: Text(
                  "Continue".toUpperCase(),
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppTheme.backgroundcolor,
                      fontWeight: FontWeight.w500,
                      fontSize: AddSize.font16),
                )),
            SizedBox(
              height: AddSize.size20,
            )
          ],
        ),
      ),
    );
  }
}
