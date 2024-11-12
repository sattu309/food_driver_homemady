import 'dart:convert';
import 'dart:developer';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady_drivers/widgets/custome_size.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/location_controller.dart';
import '../controller/order_details_controller.dart';
import '../controller/userProfile_controller.dart';
import '../firebase_service/firebase_service.dart';
import '../models/order_details_cooks_copy_model.dart';
import '../widgets/app_assets.dart';
import '../widgets/app_theme.dart';
import '../widgets/custome_textfiled.dart';
import '../widgets/dimenestion.dart';
import 'chat_screen/chatting_list_screen.dart';
import 'chat_screen/main_chat_screen.dart';

class DriverDeliveryOrderDetails extends StatefulWidget {
  const DriverDeliveryOrderDetails({Key? key, required this.orderId, this.routing}) : super(key: key);
  final String orderId;
  final bool? routing;

  @override
  _DriverDeliveryOrderDetailsState createState() => _DriverDeliveryOrderDetailsState();
}

class _DriverDeliveryOrderDetailsState extends State<DriverDeliveryOrderDetails> with SingleTickerProviderStateMixin {
  final locationController = Get.put(LocationController());
  final controller1 = Get.put(UserProfileController());
  bool value = false;
  RxBool isSelect = false.obs;
  TabController? tabController;
  final myOrderDetailsController = Get.put(MyOrderDetailsController());

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
    myOrderDetailsController.getMyOrderDetails(widget.orderId).then((value) {
      if (widget.routing == true) {
        chatWithCustomer();
      }
    });
  }

  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }


































  







  _makingPhoneCall(call) async {
    var url = Uri.parse(call);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  chatWithCustomer() async {
    String? myUserId = await getMyUserId();
    if (myUserId == null) {
      showToast("User Not Found");
      return;
    }
    String roomId = FirebaseService().createChatRoom(
        user1: myUserId.convertToNum.toInt(),
        user2: myOrderDetailsController.model.value.orderDetail!.user!.id.toString().convertToNum.toInt());
    log(roomId);
    Get.to(() => MainChatScreen(
          roomId: roomId,
          orderId: myOrderDetailsController.model.value.orderDetail!.orderId.toString(),
          receiverId: myOrderDetailsController.model.value.orderDetail!.user!.id.toString(),
          receiverName: myOrderDetailsController.model.value.orderDetail!.user!.name.toString(),
          receiverImage: myOrderDetailsController.model.value.orderDetail!.user!.profileImage.toString(),
          senderId: myUserId,
          customer: {
            "user_id": myOrderDetailsController.model.value.orderDetail!.user!.id.toString(),
            "user_name": myOrderDetailsController.model.value.orderDetail!.user!.name.toString(),
            "user_image": myOrderDetailsController.model.value.orderDetail!.user!.profileImage.toString(),
          },
          driver: {
            "user_id": myOrderDetailsController.model.value.orderDetail!.driver!.id.toString(),
            "user_name": myOrderDetailsController.model.value.orderDetail!.driver!.name.toString(),
            "user_image": myOrderDetailsController.model.value.orderDetail!.driver!.profile_image.toString(),
          },
        ));
  }

  chatWithVendor() async {
    String? myUserId = await getMyUserId();
    if (myUserId == null) {
      showToast("User Not Found");
      return;
    }
    String roomId = FirebaseService().createChatRoom(
        user1: myUserId.convertToNum.toInt(),
        user2: myOrderDetailsController.model.value.orderDetail!.vendor!.storeId.toString().convertToNum.toInt());
    log(roomId);
    Get.to(() => MainChatScreen(
          roomId: roomId,
          orderId: myOrderDetailsController.model.value.orderDetail!.orderId.toString(),
          receiverId: myOrderDetailsController.model.value.orderDetail!.vendor!.storeId.toString(),
          receiverName: myOrderDetailsController.model.value.orderDetail!.vendor!.storeName.toString(),
          receiverImage: myOrderDetailsController.model.value.orderDetail!.vendor!.storeImage.toString(),
          senderId: myUserId,
          vendor: {
            "user_id": myOrderDetailsController.model.value.orderDetail!.vendor!.storeId.toString(),
            "user_name": myOrderDetailsController.model.value.orderDetail!.vendor!.storeName.toString(),
            "user_image": myOrderDetailsController.model.value.orderDetail!.vendor!.storeImage.toString(),
          },
          driver: {
            "user_id": myOrderDetailsController.model.value.orderDetail!.driver!.id.toString(),
            "user_name": myOrderDetailsController.model.value.orderDetail!.driver!.name.toString(),
            "user_image": myOrderDetailsController.model.value.orderDetail!.driver!.profile_image.toString(),
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Obx(() {
      return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: Scaffold(
          appBar: backAppBar(title: "Delivery Details", context: context),
          body: myOrderDetailsController.isDataLoading.value && myOrderDetailsController.model.value.orderDetail != null
              ? NestedScrollView(
                  headerSliverBuilder: (_, __) {
                    return [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding10),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  addHeight(20),
                                  Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade300,
                                            offset: const Offset(
                                              .1,
                                              .1,
                                            ),
                                            blurRadius: 20.0,
                                            spreadRadius: 1.0,
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: AddSize.padding15, vertical: AddSize.padding15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                              Row(
                                                children: [
                                                  const ImageIcon(
                                                    AssetImage(AppAssets.orderList),
                                                    color: AppTheme.primaryColor,
                                                    size: 20,
                                                  ),
                                                  SizedBox(
                                                    width: AddSize.size15,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Order ID: # ${myOrderDetailsController.model.value.orderDetail!.orderId.toString()}',
                                                        style: TextStyle(
                                                            color: AppTheme.primaryColor,
                                                            fontSize: AddSize.font16,
                                                            fontWeight: FontWeight.w500),
                                                      ),
                                                      Text(
                                                        myOrderDetailsController.model.value.orderDetail!.placedAt.toString(),
                                                        style: TextStyle(
                                                            color: AppTheme.blackcolor,
                                                            fontSize: AddSize.font12,
                                                            fontWeight: FontWeight.w400),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ]),
                                            SizedBox(
                                              height: height * .02,
                                            ),
                                            ListView.builder(
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemCount: myOrderDetailsController.model.value.orderDetail!.orderItems!.length,
                                              scrollDirection: Axis.vertical,
                                              itemBuilder: (BuildContext context, int index) {
                                                return Column(
                                                  children: [
                                                    orderList(
                                                      myOrderDetailsController.model.value.orderDetail!.orderItems![index].productName
                                                          .toString(),
                                                      myOrderDetailsController.model.value.orderDetail!.orderItems![index].price
                                                          .toString(),
                                                      myOrderDetailsController.model.value.orderDetail!.orderItems![index].sizeId
                                                          .toString(),
                                                      myOrderDetailsController.model.value.orderDetail!.orderItems![index].sizeQuantity
                                                          .toString(),
                                                      myOrderDetailsController.model.value.orderDetail!.orderItems![index].qty
                                                          .toString(),
                                                      myOrderDetailsController.model.value.orderDetail!.orderItems![index].status
                                                          .toString(),
                                                    ),
                                                    SizedBox(
                                                      height: height * .005,
                                                    ),
                                                    index != 2 ? const Divider() : const SizedBox(),
                                                    SizedBox(
                                                      height: height * .005,
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      )),
                                  Obx(() {
                                    return Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Container(
                                          decoration:
                                              BoxDecoration(borderRadius: BorderRadius.circular(4), color: AppTheme.primaryColor),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: width * .04, vertical: height * .005),
                                            child: Text(
                                              myOrderDetailsController.model.value.orderDetail!.deliveryStatus.toString(),
                                              style: TextStyle(
                                                  fontSize: AddSize.font14,
                                                  color: AppTheme.backgroundcolor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )),
                                    );
                                  })
                                ],
                              ),
                              SizedBox(
                                height: AddSize.size14,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      offset: const Offset(
                                        .1,
                                        .1,
                                      ),
                                      blurRadius: 20.0,
                                      spreadRadius: 1.0,
                                    ),
                                  ],
                                ),
                                child: Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * .0001),
                                      child: TabBar(
                                        physics: const BouncingScrollPhysics(),
                                        unselectedLabelColor: AppTheme.blackcolor,
                                        labelColor: AppTheme.backgroundcolor,
                                        tabs: const [
                                          Tab(
                                            child: Text(
                                              "Customer Detail",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Tab(
                                            child: Text(
                                              "Home Cook Information",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        ],
                                        labelStyle:
                                            const TextStyle(color: AppTheme.blackcolor, fontSize: 16, fontWeight: FontWeight.w500),
                                        unselectedLabelStyle:
                                            const TextStyle(color: AppTheme.blackcolor, fontSize: 16, fontWeight: FontWeight.w500),
                                        controller: tabController,
                                        indicatorSize: TabBarIndicatorSize.tab,
                                        indicator: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: AppTheme.primaryColor,
                                        ),
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ];
                  },
                  body: myOrderDetailsController.isDataLoading.value && myOrderDetailsController.model.value.orderDetail != null
                      ? TabBarView(
                          physics: const BouncingScrollPhysics(),
                          controller: tabController,
                          children: [
                            SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: AddSize.padding16),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              offset: const Offset(
                                                .1,
                                                .1,
                                              ),
                                              blurRadius: 20.0,
                                              spreadRadius: 1.0,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Card(
                                              elevation: 0,
                                              color: AppTheme.backgroundcolor,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.symmetric(horizontal: AddSize.padding15, vertical: AddSize.padding15),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          const Text(
                                                            "Name",
                                                            style: TextStyle(
                                                                color: AppTheme.lightblack, fontWeight: FontWeight.w500, fontSize: 14),
                                                          ),
                                                          if (myOrderDetailsController.model.value.orderDetail!.user != null)
                                                            Text(
                                                              myOrderDetailsController.model.value.orderDetail!.user!.name.toString(),
                                                              style: GoogleFonts.raleway(
                                                                  color: const Color(0xFF303C5E),
                                                                  fontWeight: FontWeight.w700,
                                                                  fontSize: 16),
                                                            ),
                                                        ],
                                                      ),
                                                    ]),
                                                    GestureDetector(
                                                      onTap: chatWithCustomer,
                                                      child: Container(
                                                        height: AddSize.size45,
                                                        width: AddSize.size45,
                                                        decoration:
                                                            const ShapeDecoration(color: Color(0xFFFF980E), shape: CircleBorder()),
                                                        child: Center(
                                                            child: Image(
                                                          image: const AssetImage(AppAssets.chat),
                                                          height: AddSize.size25,
                                                          width: AddSize.size25,
                                                        )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const Divider(
                                              color: Color(0xFFEFEFEF),
                                              height: 1,
                                              thickness: 1,
                                            ),
                                            Card(
                                              elevation: 0,
                                              color: AppTheme.backgroundcolor,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.symmetric(horizontal: AddSize.padding15, vertical: AddSize.padding15),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          const Text(
                                                            "Phone no",
                                                            style: TextStyle(
                                                                color: AppTheme.lightblack, fontWeight: FontWeight.w500, fontSize: 14),
                                                          ),
                                                          if (myOrderDetailsController.model.value.orderDetail!.user != null)
                                                            Text(
                                                              myOrderDetailsController.model.value.orderDetail!.user!.phone.toString(),
                                                              style: GoogleFonts.raleway(
                                                                  color: const Color(0xFF303C5E),
                                                                  fontWeight: FontWeight.w700,
                                                                  fontSize: 16),
                                                            ),
                                                        ],
                                                      ),
                                                    ]),
                                                    GestureDetector(
                                                      onTap: () {
                                                        _makingPhoneCall("tel:+91");
                                                      },
                                                      child: Container(
                                                          height: AddSize.size45,
                                                          width: AddSize.size45,
                                                          decoration: const ShapeDecoration(
                                                              color: AppTheme.primaryColor, shape: CircleBorder()),
                                                          child: const Center(
                                                              child: Icon(
                                                            Icons.phone,
                                                            color: Colors.white,
                                                            // color: AppTheme.callPhoneColor,
                                                          ))),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const Divider(
                                              color: Color(0xFFEFEFEF),
                                              height: 1,
                                              thickness: 1,
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.symmetric(horizontal: AddSize.padding15, vertical: AddSize.padding15),
                                              child: GestureDetector(
                                                onTap: () {
                                                  openMap(
                                                      double.parse(myOrderDetailsController.model.value.orderDetail!.address!.latitude
                                                          .toString()),
                                                      double.parse(myOrderDetailsController.model.value.orderDetail!.address!.longitude
                                                          .toString()));
                                                },
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          const Text(
                                                            "Address",
                                                            style: TextStyle(
                                                                color: AppTheme.lightblack, fontWeight: FontWeight.w500, fontSize: 14),
                                                          ),
                                                          if (myOrderDetailsController.model.value.orderDetail!.address != null)
                                                            Text(
                                                              myOrderDetailsController.model.value.orderDetail!.address!.location
                                                                  .toString(),
                                                              style: GoogleFonts.raleway(
                                                                  color: const Color(0xFF303C5E),
                                                                  fontWeight: FontWeight.w700,
                                                                  fontSize: 16),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        openMap(
                                                            double.parse(myOrderDetailsController
                                                                .model.value.orderDetail!.address!.latitude
                                                                .toString()),
                                                            double.parse(myOrderDetailsController
                                                                .model.value.orderDetail!.address!.longitude
                                                                .toString()));
                                                      },
                                                      child: Container(
                                                        height: AddSize.size45,
                                                        width: AddSize.size45,
                                                        decoration:
                                                            const ShapeDecoration(color: AppTheme.lightYellow, shape: CircleBorder()),
                                                        child: const Center(
                                                            child: Icon(
                                                          Icons.location_on,
                                                          color: AppTheme.backgroundcolor,
                                                        )),
                                                      ),
                                                    )
                                                  ],

                                                  // Card(
                                                  //   elevation: 0,
                                                  //   color: AppTheme.backgroundcolor,
                                                  //   shape: RoundedRectangleBorder(
                                                  //       borderRadius: BorderRadius.circular(
                                                  //           10)),
                                                  //   child: Padding(
                                                  //     padding: EdgeInsets.symmetric(
                                                  //         horizontal: AddSize.padding15,
                                                  //         vertical: AddSize.padding15),
                                                  //     child:
                                                  //     FittedBox(
                                                  //       child: Row(
                                                  //         mainAxisAlignment:
                                                  //         MainAxisAlignment.spaceBetween,
                                                  //         children: [
                                                  //           Column(
                                                  //             crossAxisAlignment:
                                                  //             CrossAxisAlignment.start,
                                                  //             children: [
                                                  //               const Text(
                                                  //                 "Address",
                                                  //                 style: TextStyle(
                                                  //                     color:
                                                  //                     AppTheme.lightblack,
                                                  //                     fontWeight:
                                                  //                     FontWeight.w500,
                                                  //                     fontSize: 14),
                                                  //               ),
                                                  //               if( myOrderDetailsController.model.value.data!.user != null)
                                                  //               Text(
                                                  //                   myOrderDetailsController.model.value.data!.address!.location.toString(),
                                                  //                 style: GoogleFonts.raleway(
                                                  //                     color: const Color(
                                                  //                         0xFF303C5E),
                                                  //                     fontWeight:
                                                  //                     FontWeight.w700,
                                                  //                     fontSize: 16),
                                                  //               ),
                                                  //             ],
                                                  //           ),
                                                  //           addWidth(MediaQuery.of(context).size.width*.015),
                                                  //           GestureDetector(
                                                  //             onTap: () {
                                                  //               // openMap();
                                                  //             },
                                                  //             child: Container(
                                                  //               height: AddSize.size45,
                                                  //               width: AddSize.size45,
                                                  //               decoration: const ShapeDecoration(
                                                  //                   color: AppTheme.lightYellow,
                                                  //                   shape: CircleBorder()),
                                                  //               child: const Center(
                                                  //                   child: Icon(
                                                  //                     Icons.location_on,
                                                  //                     color: AppTheme
                                                  //                         .backgroundcolor,
                                                  //                   )),
                                                  //             ),
                                                  //           ),
                                                  //         ],
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      addHeight(15),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              offset: const Offset(
                                                .1,
                                                .1,
                                              ),
                                              blurRadius: 20.0,
                                              spreadRadius: 1.0,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Tip for Delivery partner:',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xff1A2E33)),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  '€ ${myOrderDetailsController.model.value.orderDetail!.tipAmount!.toString()}',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff486769)),
                                                ),
                                              ],
                                            ),
                                            addHeight(10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Text(
                                                  "Subtotal:",
                                                  style:
                                                      TextStyle(color: Color(0xFF293044), fontWeight: FontWeight.w600, fontSize: 15),
                                                ),
                                                Text(
                                                  '€ ${myOrderDetailsController.model.value.orderDetail!.grandTotal.toString()}',
                                                  style: const TextStyle(
                                                      color: Color(0xFF797F90), fontWeight: FontWeight.w400, fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      addHeight(8),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                          InkWell(
                                            onTap: chatWithCustomer,
                                            child: const Text(
                                              "Chat with customer",
                                              style: TextStyle(color: Color(0xFF293044), fontWeight: FontWeight.w600, fontSize: 14),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ],
                                  ),
                                )),
                            myOrderDetailsController.isDataLoading.value
                                ? SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: AddSize.padding16),
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.shade300,
                                                  offset: const Offset(
                                                    .1,
                                                    .1,
                                                  ),
                                                  blurRadius: 20.0,
                                                  spreadRadius: 1.0,
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              children: [
                                                Card(
                                                  elevation: 0,
                                                  color: AppTheme.backgroundcolor,
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: AddSize.padding15, vertical: AddSize.padding15),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(children: [
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              const Text(
                                                                "Store Name",
                                                                style: TextStyle(
                                                                    color: AppTheme.lightblack,
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 14),
                                                              ),
                                                              Text(
                                                                myOrderDetailsController.model.value.orderDetail!.vendor!.storeName
                                                                    .toString(),
                                                                style: GoogleFonts.raleway(
                                                                    color: const Color(0xFF303C5E),
                                                                    fontWeight: FontWeight.w700,
                                                                    fontSize: 16),
                                                              ),
                                                            ],
                                                          ),
                                                        ]),
                                                        GestureDetector(
                                                          onTap: chatWithVendor,
                                                          child: Container(
                                                            height: AddSize.size45,
                                                            width: AddSize.size45,
                                                            decoration:
                                                                const ShapeDecoration(color: Color(0xFFFF980E), shape: CircleBorder()),
                                                            child: Center(
                                                                child: Image(
                                                              image: const AssetImage(AppAssets.chat),
                                                              height: AddSize.size25,
                                                              width: AddSize.size25,
                                                            )),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const Divider(
                                                  color: Color(0xFFEFEFEF),
                                                  height: 1,
                                                  thickness: 1,
                                                ),
                                                Card(
                                                  elevation: 0,
                                                  color: AppTheme.backgroundcolor,
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: AddSize.padding15, vertical: AddSize.padding15),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(children: [
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              const Text(
                                                                "store phone no",
                                                                style: TextStyle(
                                                                    color: AppTheme.lightblack,
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 14),
                                                              ),
                                                              Text(
                                                                myOrderDetailsController.model.value.orderDetail!.vendor!.phone
                                                                    .toString(),
                                                                style: GoogleFonts.raleway(
                                                                    color: const Color(0xFF303C5E),
                                                                    fontWeight: FontWeight.w700,
                                                                    fontSize: 16),
                                                              ),
                                                            ],
                                                          ),
                                                        ]),
                                                        GestureDetector(
                                                          onTap: () {
                                                            _makingPhoneCall("tel:+91");
                                                          },
                                                          child: Container(
                                                              height: AddSize.size45,
                                                              width: AddSize.size45,
                                                              decoration: const ShapeDecoration(
                                                                  color: AppTheme.primaryColor, shape: CircleBorder()),
                                                              child: const Center(
                                                                  child: Icon(
                                                                Icons.phone,
                                                                color: Colors.white,
                                                                // color: AppTheme.callPhoneColor,
                                                              ))),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const Divider(
                                                  color: Color(0xFFEFEFEF),
                                                  height: 1,
                                                  thickness: 1,
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.symmetric(horizontal: AddSize.padding15, vertical: AddSize.padding15),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      openMap(
                                                          double.parse(
                                                            myOrderDetailsController.model.value.orderDetail!.vendor!.latitude
                                                                .toString(),
                                                          ),
                                                          double.parse(
                                                            myOrderDetailsController.model.value.orderDetail!.vendor!.longitude
                                                                .toString(),
                                                          ));
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              const Text(
                                                                "store address",
                                                                style: TextStyle(
                                                                    color: AppTheme.lightblack,
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 14),
                                                              ),
                                                              if (myOrderDetailsController.model.value.orderDetail!.user != null)
                                                                Text(
                                                                  myOrderDetailsController.model.value.orderDetail!.vendor!.location
                                                                      .toString(),
                                                                  style: GoogleFonts.raleway(
                                                                      color: const Color(0xFF303C5E),
                                                                      fontWeight: FontWeight.w700,
                                                                      fontSize: 16),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            openMap(
                                                                double.parse(
                                                                  myOrderDetailsController.model.value.orderDetail!.vendor!.latitude
                                                                      .toString(),
                                                                ),
                                                                double.parse(
                                                                  myOrderDetailsController.model.value.orderDetail!.vendor!.longitude
                                                                      .toString(),
                                                                ));
                                                          },
                                                          child: Container(
                                                            height: AddSize.size45,
                                                            width: AddSize.size45,
                                                            decoration: const ShapeDecoration(
                                                                color: AppTheme.lightYellow, shape: CircleBorder()),
                                                            child: const Center(
                                                                child: Icon(
                                                              Icons.location_on,
                                                              color: AppTheme.backgroundcolor,
                                                            )),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                // Card(
                                                //   elevation: 0,
                                                //   color: AppTheme.backgroundcolor,
                                                //   shape: RoundedRectangleBorder(
                                                //       borderRadius: BorderRadius.circular(
                                                //           10)),
                                                //   child: Padding(
                                                //     padding: EdgeInsets.symmetric(
                                                //         horizontal: AddSize.padding15,
                                                //         vertical: AddSize.padding15),
                                                //     child:
                                                //     Row(
                                                //       mainAxisAlignment:
                                                //       MainAxisAlignment.spaceBetween,
                                                //       children: [
                                                //         Row(children: [
                                                //           Column(
                                                //             crossAxisAlignment:
                                                //             CrossAxisAlignment.start,
                                                //             children: [
                                                //               const Text(
                                                //                 "store address",
                                                //                 style: TextStyle(
                                                //                     color:
                                                //                     AppTheme.lightblack,
                                                //                     fontWeight:
                                                //                     FontWeight.w500,
                                                //                     fontSize: 14),
                                                //               ),
                                                //               Text(
                                                //                   myOrderDetailsController.model.value.data!.vendor!.location.toString(),
                                                //                 style: GoogleFonts.raleway(
                                                //                     color: const Color(
                                                //                         0xFF303C5E),
                                                //                     fontWeight:
                                                //                     FontWeight.w700,
                                                //                     fontSize: 16),
                                                //               ),
                                                //             ],
                                                //           ),
                                                //         ]),
                                                //         GestureDetector(
                                                //           onTap: () {
                                                //             // openMap();
                                                //           },
                                                //           child: Container(
                                                //             height: AddSize.size45,
                                                //             width: AddSize.size45,
                                                //             decoration: const ShapeDecoration(
                                                //                 color: AppTheme.lightYellow,
                                                //                 shape: CircleBorder()),
                                                //             child: const Center(
                                                //                 child: Icon(
                                                //                   Icons.location_on,
                                                //                   color: AppTheme
                                                //                       .backgroundcolor,
                                                //                 )),
                                                //           ),
                                                //         ),
                                                //       ],
                                                //     ),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          addHeight(15),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.shade300,
                                                  offset: const Offset(
                                                    .1,
                                                    .1,
                                                  ),
                                                  blurRadius: 20.0,
                                                  spreadRadius: 1.0,
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Tip for Delivery partner:',
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xff1A2E33)),
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      '€ ${myOrderDetailsController.model.value.orderDetail!.tipAmount.toString()}',
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff486769)),
                                                    ),
                                                  ],
                                                ),
                                                addHeight(10),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "Subtotal:",
                                                      style: TextStyle(
                                                          color: Color(0xFF293044), fontWeight: FontWeight.w600, fontSize: 15),
                                                    ),
                                                    Text(
                                                      '€${myOrderDetailsController.model.value.orderDetail!.grandTotal.toString()}',
                                                      style: const TextStyle(
                                                          color: Color(0xFF797F90), fontWeight: FontWeight.w400, fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          addHeight(8),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                              InkWell(
                                                onTap: chatWithVendor,
                                                child: const Text(
                                                  "Chat with Cook",
                                                  style:
                                                      TextStyle(color: Color(0xFF293044), fontWeight: FontWeight.w600, fontSize: 14),
                                                ),
                                              ),
                                              // ElevatedButton(onPressed: (){
                                              //   // print("Helloo");
                                              //   OrderDetail gg = myOrderDetailsController.model.value.orderDetail!;
                                              //   log("Order data${jsonEncode(myOrderDetailsController.model.value.orderDetail)}");
                                              //   gg.user = User.fromJson(controller1.model.value.data!.toJson());
                                              //   gg.vendorID = gg.vendor!.id.toString();
                                              //   String roomId = FirebaseService().createChatRoom(
                                              //       user1: gg.user!.id!
                                              //           .toString()
                                              //           .convertToNum
                                              //           .toInt(),
                                              //       user2: gg.vendor!.id!
                                              //           .toString()
                                              //           .convertToNum
                                              //           .toInt());
                                              //   Get.to(const ChatScreen1(), arguments: [
                                              //     roomId,
                                              //     myOrderDetailsController.model.value.orderDetail!.user!.id!
                                              //         .toString()
                                              //         .convertToNum
                                              //         .toInt()
                                              //         .toString(),
                                              //     gg
                                              //   ]);
                                              //
                                              // },
                                              //     style: ElevatedButton.styleFrom(
                                              //       padding: EdgeInsets.symmetric(
                                              //           horizontal: AddSize.padding22),
                                              //       minimumSize:
                                              //       Size(AddSize.size100, AddSize.size20 * 1.8),
                                              //       primary: AppTheme.primaryColor,
                                              //       elevation: 0,
                                              //       shape: RoundedRectangleBorder(
                                              //           borderRadius: BorderRadius.circular(6)),
                                              //     ),
                                              //     child: Text(
                                              //       "Chat".toUpperCase(),
                                              //       style: Theme.of(context).textTheme.headline5!.copyWith(
                                              //           color: AppTheme.backgroundcolor,
                                              //           fontWeight: FontWeight.w500,
                                              //           fontSize: AddSize.font14),
                                              //     ))
                                            ]),
                                          ),
                                        ],
                                      ),
                                    ))
                                : const CircularProgressIndicator(
                                    color: Color(0xff7ED957),
                                  ),
                          ],
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xff7ED957),
                          ),
                        ),
                )
              : const Center(
                  child: CircularProgressIndicator(
                  color: Color(0xff7ED957),
                )),
        ),
      );
    });
  }

  paymentDetails({
    required subTotal,
    required delivery,
    required total,
    required orderType,
  }) {
    return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AddSize.padding15, vertical: AddSize.padding15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                details("Subtotal:", "₹$subTotal"),
                SizedBox(
                  height: AddSize.size5,
                ),
                details("Delivery charges:", "₹$delivery"),
                SizedBox(
                  height: AddSize.size5,
                ),
                // details("Packing charges:", "₹$packing"),
                SizedBox(
                  height: AddSize.size5,
                ),
                // myOrderDetailsController
                //     .model.value.data!.tax !=0 ?
                // Column(children: [
                //   details("Tax & fee:",
                //       "₹${myOrderDetailsController
                //           .model.value.data!.tax ?? ""}"),
                //   SizedBox(
                //     height: AddSize.size5,
                //   ),
                // ],):const SizedBox(),
                // myOrderDetailsController
                //     .model.value.data!.tax1 !=null ?
                // Column(children: [
                //   details("${myOrderDetailsController
                //       .model.value.data!.tax1!.type ?? ""}:",
                //       "₹${myOrderDetailsController
                //           .model.value.data!.tax1!.amount ?? ""}"),
                //   SizedBox(
                //     height: AddSize.size5,
                //   ),
                // ],):const SizedBox(),
                // myOrderDetailsController
                //     .model.value.data!.tax2 !=null ?
                // Column(children: [
                //   details("${myOrderDetailsController
                //       .model.value.data!.tax2!.type ?? ""}:",
                //       "₹${myOrderDetailsController
                //           .model.value.data!.tax2!.amount ?? ""}"),
                //   SizedBox(
                //     height: AddSize.size10,
                //   ),
                // ],):const SizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total:",
                        style: TextStyle(color: AppTheme.primaryColor, fontSize: AddSize.font16, fontWeight: FontWeight.w500)),
                    Text("₹$total", style: TextStyle(color: Colors.grey, fontSize: AddSize.font14, fontWeight: FontWeight.w500))
                  ],
                ),
                SizedBox(
                  height: AddSize.size5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          // Get.toNamed(MyRouter.editProfileScreen);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(AddSize.size50, AddSize.size30),
                          backgroundColor: AppTheme.primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        ),
                        child: Text(
                          orderType,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: AppTheme.backgroundcolor, fontWeight: FontWeight.w500, fontSize: AddSize.font14),
                        )),
                  ],
                )
              ],
            )));
  }

  details(title, price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(color: AppTheme.blackcolor, fontSize: AddSize.font16, fontWeight: FontWeight.w500)),
        Text(price, style: TextStyle(color: Colors.grey, fontSize: AddSize.font14, fontWeight: FontWeight.w500))
      ],
    );
  }

  orderList(name, price, sizeOfProduct, sizeQty, itemQty, status) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(fontSize: AddSize.font16, color: AppTheme.blackcolor, fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                "€$price",
                style: TextStyle(fontSize: AddSize.font16, color: AppTheme.primaryColor, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * .01,
        ),
        Row(
          children: [
            Text(
              sizeQty,
              style: TextStyle(fontSize: AddSize.font14, color: AppTheme.lightblack, fontWeight: FontWeight.w500),
            ),
            Text(
              sizeOfProduct,
              style: TextStyle(fontSize: AddSize.font14, color: AppTheme.lightblack, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: width * .01,
            ),
            const Text("*"),
            SizedBox(
              width: width * .01,
            ),
            Text(
              itemQty,
              style: TextStyle(fontSize: AddSize.font14, color: AppTheme.lightblack, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: width * .05,
            ),
            status == "R"
                ? Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.red),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * .04, vertical: height * .005),
                      child: Text(
                        "Rejected",
                        style: TextStyle(fontSize: AddSize.font14, color: AppTheme.backgroundcolor, fontWeight: FontWeight.w500),
                      ),
                    ))
                : const SizedBox()
          ],
        ),
      ],
    );
  }
}
