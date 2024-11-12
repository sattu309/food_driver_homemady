import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/privacy_policy_controller.dart';
import 'package:flutter_html/flutter_html.dart';
import '../widgets/custome_textfiled.dart';


class PrivacyPolicies extends StatefulWidget {
  const PrivacyPolicies({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicies> createState() => _PrivacyPoliciesState();
}

class _PrivacyPoliciesState extends State<PrivacyPolicies> {
  final controller = Get.put(PrivacyController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: Scaffold(
          appBar: backAppBar(title: 'Privacy Policy :', context: context),
          body: controller.isDataLoading.value && controller.model.value.data != null ?
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 16),
              child: Column(
                children:  [
                  Html(
                    data: controller.model.value.data!.content.toString(),
                    style: {
                      'body': Style(
                          fontWeight: FontWeight.w400,
                          fontSize:  FontSize(13 ),
                          color: const Color(0xFF363539)
                      )
                    },
                  )
                ],
              ),
            ) ,
          ) : const Center(child: CircularProgressIndicator(color: Color(0xff7ED957),)),
        ),
      );
    });
  }
}
