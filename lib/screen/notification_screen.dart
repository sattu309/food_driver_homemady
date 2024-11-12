import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady_drivers/controller/assigned_Orderlist_controller.dart';
import '../controller/notification_controller.dart';
import '../controller/order_details_controller.dart';
import '../widgets/app_theme.dart';
import '../widgets/custome_size.dart';
import '../widgets/custome_textfiled.dart';
import '../widgets/dimenestion.dart';
import 'order_details.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final controller = Get.put(NotificationController());
  final myOrderDetailsController = Get.put(MyOrderDetailsController());

  @override
  void initState() {
    super.initState();
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: backAppBar(title: "Notification", context: context),
        body: Obx(() {
          return controller.isDataLoading.value
              ? Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child:
                            controller.isDataLoading.value && controller.model.value.data!.notificationData!.isNotEmpty
                                ? ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: controller.model.value.data!.notificationData!.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          // myOrderDetailsController.id.value= controller.model.value.data!.notificationData![index].orderId.toString();
                                          // print("Order id is ${myOrderDetailsController.id.value}");
                                          Get.to(() => DriverDeliveryOrderDetails(
                                                orderId: controller.model.value.data!.notificationData![index].orderId
                                                    .toString(),
                                              ));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
                                          child: Container(
                                            height: 95,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: const Color(0xFF04666E).withOpacity(0.10),
                                                  offset: const Offset(
                                                    .1,
                                                    .1,
                                                  ),
                                                  blurRadius: 19.0,
                                                  spreadRadius: 1.0,
                                                )
                                              ],
                                            ),
                                            width: Get.width,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                addWidth(8),
                                                Container(
                                                  height: 60,
                                                  width: 3,
                                                  decoration: const BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                                    color: Color(0xff7ED957),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 13,
                                                ),
                                                const SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child: CircleAvatar(
                                                    backgroundColor: Color(0xff7ED957),
                                                    child: Text(
                                                      'B',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 6,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 10, right: 6),
                                                        child: Text(
                                                          controller.model.value.data!.notificationData![index].time
                                                              .toString(),
                                                          style: GoogleFonts.poppins(
                                                            fontSize: 11,
                                                            fontWeight: FontWeight.w400,
                                                            color: const Color(0xff7ED957),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 10, top: 2),
                                                        child: Text(
                                                          controller.model.value.data!.notificationData![index].title
                                                              .toString(),
                                                          style: GoogleFonts.poppins(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w400,
                                                            color: const Color(0xff000000),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 2, left: 10, right: 10),
                                                        child: Text(
                                                          controller.model.value.data!.notificationData![index].body
                                                              .toString(),
                                                          style: GoogleFonts.poppins(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w300,
                                                            color: const Color(0xff292F34),
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
                                      );
                                    })
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/notif.png',
                                        height: MediaQuery.of(context).size.height * .25,
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height * .030,
                                      ),
                                      Text("No Notifications Yet",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                              height: 1.5,
                                              fontWeight: FontWeight.w700,
                                              fontSize: AddSize.font20,
                                              color: AppTheme.blackcolor)),
                                      addHeight(
                                        MediaQuery.of(context).size.height * .010,
                                      ),
                                      Text("Bong, it seems that you do not have any notifications at the moment",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                              height: 1.5,
                                              fontWeight: FontWeight.w500,
                                              fontSize: AddSize.font16,
                                              color: const Color(0xFF9E9E9E))),
                                    ],
                                  )),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(
                  color: AppTheme.primaryColor,
                ));
        }).manageNotification(context: context),
      ),
    );
  }
}
