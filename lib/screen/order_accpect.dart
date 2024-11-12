import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routers/routers.dart';
import '../widgets/app_assets.dart';
import '../widgets/custome_textfiled.dart';
import '../widgets/dimenestion.dart';


class OrderAccept extends StatefulWidget {
  const OrderAccept({Key? key}) : super(key: key);

  @override
  State<OrderAccept> createState() => _OrderAcceptState();
}

class _OrderAcceptState extends State<OrderAccept> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
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
                  SizedBox(
                    height: AddSize.size80,
                  ),
                   Text(
                    "Your Order delivered successfully".tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 28,
                        color:  Color(0xff262F33)),
                  ),
                  const SizedBox(
                    height: 15,
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
                Get.toNamed(MyRouters.feedBackScreen);
              },
            )
        ),
      ),
    );
  }
}
