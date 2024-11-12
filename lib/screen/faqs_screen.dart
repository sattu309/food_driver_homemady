import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../models/faq_model.dart';
import '../repository/faq_repo.dart';
import '../widgets/custome_textfiled.dart';
import '../widgets/new_helper.dart';

class FaqsScreen extends StatefulWidget {
  const FaqsScreen({Key? key}) : super(key: key);

  @override
  State<FaqsScreen> createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
  Rx<faqScreen> faq = faqScreen().obs;
  Rx<RxStatus> statusOffaq = RxStatus
      .empty()
      .obs;
  RxString type = 'driver'.obs;
  Future getFaq() async {
    await faqRepo(type: 'driver').then((value) {
      faq.value = value;
      if (value.status == true) {
        statusOffaq.value = RxStatus.success();
        NewHelper.showToast(value.message.toString());
      } else {
        statusOffaq.value = RxStatus.error();
        NewHelper.showToast(value.message.toString());
      }
    }

    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFaq();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: backAppBar(title: 'Faqs :', context: context),

        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Obx(() {
            return statusOffaq.value.isSuccess ?
              ListView.builder(
                itemCount: faq.value.data!.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color(0xffDCDCDC), width: 1),
                        ),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                              dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            trailing: (faq.value.data![index].senderExpansion == false)
                                ? const Icon(
                              Icons.add,
                              color: Color(0xFF7ED957),
                            )
                                : const Icon(
                              Icons.remove,
                              color: Color(0xFF7ED957),
                            ),
                            onExpansionChanged: (value) {
                              setState(() {
                                faq.value.data![index].senderExpansion = value;
                              });
                            },
                            title:  Text("${index + 1}. ${faq.value.data![index].question}",
                              style: const TextStyle(
                                color: Color(0xFF1D1D1D),
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            children: <Widget>[
                              ListTile(
                                visualDensity: VisualDensity.compact,
                                dense: true,
                                iconColor: const Color(0xFF07B6CA),
                                      isThreeLine: true,
                                      subtitle: Html(
                                        data: "Answer${faq.value.data![index].answer}",
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            )  : const Center(
              child: CircularProgressIndicator(color: Color(0xff7ED957),),
            );
          }),
        ),
      ),
    );
  }
}