import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/assigned_orderList_model.dart';
import '../repository/assigned_orderList_repo.dart';
import '../screen/order_details.dart';
import '../widgets/custome_size.dart';

class AssignedOrderController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<assgnedOrderList> model = assgnedOrderList().obs;
  RxString status = "".obs;
  bool gg = false;
  RxInt refreshInt = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getOrderData1();
  }

  Future getOrderData1() async {
    if (gg == true) return;
    gg = true;
    await assignedOrderListRepo(filterKeyword: status.value).then((value) {
      gg = false;
      isDataLoading.value = true;
      refreshInt.value = DateTime.now().millisecondsSinceEpoch;
      model.value = value;
    }).catchError((e) {
      gg = false;
    });
  }
}

extension ManageNotification on Widget {
  Widget manageNotification({bool? safeArea, required BuildContext context}) {
    final controller = Get.put(AssignedOrderController());
    return Obx(() {
      if (controller.refreshInt.value > 0) {}
      return Stack(
        children: [
          this,
          const SizedBox.expand(),
          if (controller.model.value.data != null &&
              controller.model.value.data != null &&
              controller.model.value.data!.isNotEmpty)
            if (controller.model.value.data!.first.orderStatus != 'Cancelled' &&
                controller.model.value.data!.first.orderStatus != 'Completed')

              Positioned(
                  bottom:0,
                  right: 0,
                  left: 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ).copyWith(bottom: 20),
                        child: Hero(
                          tag: "notification_tag",
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => DriverDeliveryOrderDetails(
                                  orderId: controller.model.value.data!.first.orderId.toString()));
                            },
                            child: Material(
                              color: Colors.transparent,
                              elevation: 5,
                              surfaceTintColor: Colors.transparent,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    addWidth(8),
                                    Container(
                                      height: 54,
                                      width: 3,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                        color: Colors.green,
                                      ),
                                      // child: VerticalDivider(
                                      //   color: Color(0xffFF6100),
                                      //   thickness: 2.5,
                                      // ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    const SizedBox(
                                      height: 32,
                                      width: 32,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.green,
                                        child: Text(
                                          'B',
                                          style:
                                              TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10, right: 6),
                                            child: Text(
                                              controller.model.value.data!.first.date.toString(),
                                              style: GoogleFonts.poppins(
                                                fontSize: 11.5,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: Text(
                                              controller.model.value.data!.first.orderStatus.toString(),
                                              style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10, right: 10),
                                            child: Text(
                                              "You Order #${controller.model.value.data!.first.orderId.toString()}",
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
        ],
      );
    });
  }
}
