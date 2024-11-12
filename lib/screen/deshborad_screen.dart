import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemady_drivers/models/app_version_model.dart';
import 'package:homemady_drivers/repository/app_version_repo.dart';
import 'package:homemady_drivers/routers/routers.dart';
import 'package:homemady_drivers/widgets/custome_size.dart';
import 'package:homemady_drivers/widgets/new_helper.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/assigned_Orderlist_controller.dart';
import '../controller/deshborad_controoler.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../controller/driver_information_controller.dart';
import '../controller/get_feedback_controller.dart';
import '../controller/location_controller.dart';
import '../controller/order_details_controller.dart';
import '../controller/userProfile_controller.dart';
import '../firebase_service/firebase_service.dart';
import '../login_signup/login_screen.dart';
import '../models/verify_otp_model.dart';
import '../repository/assigned_order_repo.dart';
import '../repository/delivery_mode_update_repo.dart';
import '../repository/notificatoin_repo.dart';
import '../repository/set_delivery_range_repo.dart';
import '../services/notification_service.dart';
import '../widgets/app_theme.dart';
import '../widgets/dimenestion.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'chat_screen/chatting_list_screen.dart';
import 'chat_screen/main_chat_screen.dart';
import 'order_details.dart';

io.Socket? socket1;

class DashbordScreen extends StatefulWidget {
  const DashbordScreen({Key? key}) : super(key: key);

  @override
  State<DashbordScreen> createState() => _DashbordScreenState();
}

class _DashbordScreenState extends State<DashbordScreen> {
  bool state = true;
  int currentDrawer = 0;
  int value1 = 1;
  bool? value2 = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = Get.put(DeshBoradController());
  final controller1 = Get.put(UserProfileController());
  final assignedController = Get.put(AssignedOrderController());
  final controllerFeedback = Get.put(GetFeedbackController());
  final controllerDriverId = Get.put(DriverInformationController());
  final locationController = Get.put(LocationController());

  List days = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];

  final RxBool _store = false.obs;

  Rx<RxStatus> statusOfGetUpdate = RxStatus.empty().obs;

  Rx<ModelAppVersion> appVersionModel = ModelAppVersion().obs;

  bool userLogin = false;
  String currentVersion = '';
  String latestVersion = '';
  Future<void> checkVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      currentVersion = packageInfo.version;
    });
    getUpdateVersion(
        versioncode: currentVersion.toString(),
        type: Platform.isIOS ? "ios" : "android")
        .then((value) {
      appVersionModel.value = value;
      print("object");
      if (value.data!.isUpdated == false) {
        print("api");
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('New Version Available'),
                content: Text(
                    'A new version is available. Would you like to update?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      if (Platform.isAndroid) {
                        _launchPlayStore();
                      } else if (Platform.isIOS) {
                        _launchAppStore();
                      }
                    },
                    child: Text('Update Now'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Later'),
                  ),
                ],
              );
            });
        statusOfGetUpdate.value = RxStatus.success();
      } else {
        statusOfGetUpdate.value = RxStatus.error();
      }
      setState(() {});
// showToast(value.message.toString());
    });
// Replace 'YOUR_APP_ID' with your app's ID on the App Store
// final response = await http.get(Uri.parse(
// "https://itunes.apple.com/lookup?bundleId=com.referralApp.referralApp"));
//
// if (response.statusCode == 200) {
// final Map<String, dynamic> data = json.decode(response.body);
// if (data['results'].isNotEmpty) {
// final appData = data['results'][0];
// final String latestVersion1 = appData['version'];
//
// setState(() {
// print("version>>>>>" + latestVersion1);
// latestVersion = latestVersion1;
//
// });
// }
// }
  }
  version() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;
    print('app version is${appVersion.toString()}');
  }
  _launchAppStore() async {
    const url =
        'https://apps.apple.com/us/app/homemady-driver/id6451481144'; // Replace this with your App Store link
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  void _launchPlayStore() async {
    final String packageName =
        'com.homemady.homemady_drivers'; // Replace with your app's package name
    final url = 'market://details?id=$packageName';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      final fallbackUrl =

          'https://play.google.com/store/apps/details?id=$packageName';
      await launch(fallbackUrl);
    }
  }

  connectToServer() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ModelVerifyOtp? user = ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
    if (socket1 != null) {
      socket1!.disconnect();
      socket1!.dispose();
    }
    //192.168.1.28      54.204.238.132
    io.Socket socket = io.io('http://79.125.89.222:3001/driver', <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
      "extraHeaders": {"access_token": user.authToken.toString()},
    });

    socket.onError((data) {
      // if (kDebugMode) {
      //   if (kDebugMode) // print('==================  onError $data');
      // }
    });
    socket.onDisconnect((data) {
      // if (kDebugMode) {
      //   if (kDebugMode) // print('==================  onDisconnect $data');
      // }
    });
    socket.onConnecting((data) {
      // if (kDebugMode) {
      //   if (kDebugMode) // print('onConnecting $data');
      //
      // }
    });

    socket.onConnectTimeout((data) {
      // if (kDebugMode) {
      //   if (kDebugMode) // print('onConnectTimeout $data');
      // }
    });
    socket.connect();
    socket1 = socket;
    socket.onConnect((data) {
      repeatEmit = Timer.periodic(const Duration(minutes: 5), (timer) {
        socket.emit('get_data', {"latitude": locationController.lat.value, "longitude": locationController.long.value});
      });
      log({"latitude": locationController.lat.value, "longitude": locationController.long.value}.toString());
    });
  }

  late StreamSubscription<RemoteMessage> streamSubscription;
  late StreamSubscription<RemoteMessage> streamSubscriptionOnOpen;

  onMessage(RemoteMessage event) {
    log("Notification received..........   onMessage        ${event.toMap()}");
    showNotificationDialog(event);
    assignedController.getOrderData1();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      NotificationService().showNotificationWithRemoteMessage(remoteMessage: event);
    });
  }

  showNotificationDialog(RemoteMessage remoteMessage) {
    FirebaseMessaging.instance.getToken().then((value) {
      log("FCM Token...      ${value}");
    });
    showSimpleNotification(
        GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.translucent,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: const Color(0xFF04666E).withOpacity(0.14),
                    spreadRadius: 1.0,
                    blurRadius: 20.0,
                    offset: const Offset(3.0, 3.0))
              ],
            ),
            margin: const EdgeInsets.all(5),
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
                  // child: VerticalDivider(
                  //   color: Color(0xffFF6100),
                  //   thickness: 2.5,
                  // ),
                ),
                const SizedBox(
                  width: 13,
                ),
                SizedBox(
                  height: 30,
                  width: 30,
                  child: CircleAvatar(
                    backgroundColor: const Color(0xff7ED957),
                    child: Text(
                      remoteMessage.notification!.title == null
                          ? 'B'
                          : remoteMessage.notification!.title.toString().substring(0, 1),
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
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
                          remoteMessage.notification!.title ?? "",
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
                          remoteMessage.notification!.body ?? "",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff000000),
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
        slideDismiss: true,
        duration: const Duration(seconds: 15),
        background: Colors.transparent,
        elevation: 50,
        contentPadding: EdgeInsets.zero);
  }

  onMessageOpenApp(RemoteMessage event) {
    assignedController.getOrderData1();
    log("Notification received..........   onMessageOpenApp        ${event.toMap()}");
    Map<dynamic, dynamic> map = event.data;
    if (map["order_id"] != null) {
      final orderController = Get.put(MyOrderDetailsController());
      // orderController.id.value = map["order_id"].toString();
      Get.to(() => DriverDeliveryOrderDetails(
            orderId: map["order_id"].toString(),
          ));
    }
  }

  onBackground(RemoteMessage? event) {
    if (event == null) return;
    Map<dynamic, dynamic> map = event.data;
    if (map["order_id"] != null) {
      // orderController.id.value = map["order_id"].toString();
      Get.to(() => DriverDeliveryOrderDetails(
            orderId: map["order_id"].toString(),
          ));
    }
    log("Notification received..........   getInitialMessage        ${event.toMap()}");
  }

  notificationHandler() {
    streamSubscription = FirebaseMessaging.onMessage.listen(onMessage);
    streamSubscriptionOnOpen = FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpenApp);
    FirebaseMessaging.instance.getInitialMessage().then(onBackground);
  }

  late Timer repeatEmit;

  @override
  void initState() {
    super.initState();
    checkVersion();
    notificationHandler();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      connectToServer();
      controller.getData();
      controller1.getData();
      controllerFeedback.getData();
      controllerDriverId.getData();
    });
    _store;
  }

  @override
  void dispose() {
    super.dispose();
    streamSubscription.cancel();
    streamSubscriptionOnOpen.cancel();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.instance.getToken().then((value) {
      print("token...       $value");
    });
    final screenSize = MediaQuery.of(context).size;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Obx(() {
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  //height: 230,
                  child: DrawerHeader(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          Color(0xFF7ED957),
                          Color(0xFF68C541),
                        ],
                      )),
                      child: Column(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                // Get.to(navigationPage.elementAt(_currentPage))
                                // Get.to(MyProfile());
                              },
                              child: Obx(() {
                                return Card(
                                    elevation: 3,
                                    shape: const CircleBorder(),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Container(
                                        margin: const EdgeInsets.all(4),
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        decoration: const ShapeDecoration(
                                          shape: CircleBorder(),
                                          color: Colors.white,
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: controller1.isDataLoading.value
                                              ? (controller1.model.value.data!.profileImage ?? "").toString()
                                              : "",
                                          height: screenSize.height * 0.12,
                                          width: screenSize.height * 0.12,
                                          errorWidget: (_, __, ___) => const SizedBox(),
                                          placeholder: (_, __) => const SizedBox(),
                                          fit: BoxFit.cover,
                                        )));
                              }),
                            ),
                          ),
                          // Expanded(
                          //   child:  Obx((){
                          //     return  Container(
                          //       margin: const EdgeInsets.all(4),
                          //       clipBehavior: Clip.antiAliasWithSaveLayer,
                          //       decoration: const ShapeDecoration(
                          //         shape: CircleBorder(),
                          //         color: Colors.white,
                          //       ),
                          //       child: CachedNetworkImage(
                          //         imageUrl:
                          //         controller1.isDataLoading.value
                          //             ? (controller1.model.value.data!
                          //             .profileImage ??
                          //             "")
                          //             .toString()
                          //         // : "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                          //             :    'assets/images/user_img.png',
                          //         height: screenSize.height * 0.12,
                          //         width: screenSize.height * 0.12,
                          //         errorWidget: (_, __, ___) => Image.asset(
                          //           'assets/images/user_img.png',
                          //           fit: BoxFit.cover,
                          //           height: 50,
                          //           width: 50,
                          //         ),
                          //         placeholder: (_, __) => const SizedBox(),
                          //         fit: BoxFit.cover,
                          //       ),
                          //     );
                          //   }),
                          // ),
                          // SizedBox(
                          //   height: MediaQuery.of(context).size.height * 0.008,
                          // ),
                          Text(
                              controller1.isDataLoading.value
                                  ? controller1.model.value.data!.name.toString().capitalizeFirst.toString()
                                  : "TestVendor",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: const Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w600,
                              )),
                          Text(
                              controller1.isDataLoading.value
                                  ? controller1.model.value.data!.email.toString()
                                  : "TestVendor@gmail.com",
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: const Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w400,
                              )),
                        ],
                      )),
                ),
                ListTile(
                  visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                  leading: Image.asset(
                    'assets/images/dashboard_icon.png',
                    height: 18,
                  ),
                  title: Text('Dashboard',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: const Color(0xFF4F535E),
                        fontWeight: FontWeight.w400,
                      )),
                  onTap: () {
                    setState(() {
                      currentDrawer = 0;
                      Get.back();
                    });
                  },
                ),
                const Divider(
                  height: 5,
                  color: Color(0xffEFEFEF),
                  thickness: 1,
                ),
                ListTile(
                  visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                  leading: Image.asset(
                    'assets/images/personImg.png',
                    height: 18,
                  ),
                  title: Text('My Account',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: const Color(0xFF4F535E),
                        fontWeight: FontWeight.w400,
                      )),
                  onTap: () {
                    setState(() {
                      currentDrawer = 1;
                      Get.toNamed(MyRouters.myProfileScreen);
                      // Get.to(VendorOrderList());
                    });
                  },
                ),
                const Divider(
                  height: 5,
                  color: Color(0xffEFEFEF),
                  thickness: 1,
                ),
                ListTile(
                  visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                  leading: Image.asset(
                    'assets/images/time_track.png',
                    height: 18,
                  ),
                  title: Text('Assigned Orders',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: const Color(0xFF4F535E),
                        fontWeight: FontWeight.w400,
                      )),
                  onTap: () {
                    Get.toNamed(MyRouters.assignedOrderScreen);
                  },
                ),
                const Divider(
                  height: 5,
                  color: Color(0xffEFEFEF),
                  thickness: 1,
                ),
                ListTile(
                  visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                  leading: Image.asset(
                    'assets/images/notification-img.png',
                    height: 18,
                  ),
                  title: Text('Notifications',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: const Color(0xFF4F535E),
                        fontWeight: FontWeight.w400,
                      )),
                  onTap: () {
                    Get.toNamed(MyRouters.notificationScreen);
                  },
                ),
                const Divider(
                  height: 5,
                  color: Color(0xffEFEFEF),
                  thickness: 1,
                ),
                ListTile(
                  visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                  leading: Image.asset(
                    'assets/images/bx_wallet.png',
                    height: 18,
                  ),
                  title: Text('Bank Details',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: const Color(0xFF4F535E),
                        fontWeight: FontWeight.w400,
                      )),
                  onTap: () {
                    setState(() {
                      currentDrawer = 3;
                      Get.toNamed(MyRouters.bankDetailsScreen);
                    });
                  },
                ),
                const Divider(
                  height: 5,
                  color: Color(0xffEFEFEF),
                  thickness: 1,
                ),
                ListTile(
                  visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                  leading: Image.asset(
                    'assets/images/earn.png',
                    height: 17,
                  ),
                  title: Text('My Earnings',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: const Color(0xFF4F535E),
                        fontWeight: FontWeight.w400,
                      )),
                  onTap: () {
                    setState(() {
                      currentDrawer = 3;
                      Get.toNamed(MyRouters.driverWithdrawMoney);
                    });
                  },
                ),
                const Divider(
                  height: 5,
                  color: Color(0xffEFEFEF),
                  thickness: 1,
                ),
                ListTile(
                  visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                  leading: Image.asset(
                    'assets/images/message.png',
                    height: 17,
                  ),
                  title: Text('My Chats',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: const Color(0xFF4F535E),
                        fontWeight: FontWeight.w400,
                      )),
                  onTap: () async {
                    currentDrawer = 5;
                    String? myUserId = await getMyUserId();
                    if (myUserId == null) return;
                    Get.to(() => ChattingListScreen(
                          myUserId: myUserId!,
                        ));
                  },
                ),
                const Divider(
                  height: 5,
                  color: Color(0xffEFEFEF),
                  thickness: 1,
                ),
                ListTile(
                  visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                  leading: Image.asset(
                    'assets/images/bx_wallet.png',
                    height: 17,
                  ),
                  title: Text('Update Driver Settings',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: const Color(0xFF4F535E),
                        fontWeight: FontWeight.w400,
                      )),
                  onTap: () {
                    setState(() {
                      currentDrawer = 5;
                      Get.toNamed(MyRouters.deliveryPartnerUpdateScreen);
                    });
                  },
                ),
                const Divider(
                  height: 5,
                  color: Color(0xffEFEFEF),
                  thickness: 1,
                ),
                ListTile(
                  visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                  leading: Image.asset(
                    'assets/images/feedback_img.png',
                    height: 20,
                    color: const Color(0xFF4F535E),
                  ),
                  title: Text('Feedback',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: const Color(0xFF4F535E),
                        fontWeight: FontWeight.w400,
                      )),
                  onTap: () {
                    setState(() {
                      controllerFeedback.driverId.value = controllerDriverId.model.value.data!.driverId.toString();
                      Get.toNamed(MyRouters.feedBackScreen);
                    });
                  },
                ),
                const Divider(
                  height: 5,
                  color: Color(0xffEFEFEF),
                  thickness: 1,
                ),
                ListTile(
                  visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                  leading: Image.asset(
                    'assets/images/metro-security.png',
                    height: 18,
                  ),
                  title: Text('Privacy Policy',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: const Color(0xFF4F535E),
                        fontWeight: FontWeight.w400,
                      )),
                  onTap: () {
                    setState(() {
                      currentDrawer = 6;
                      Get.toNamed(MyRouters.privacyPolicies);
                    });
                  },
                ),
                const Divider(
                  height: 5,
                  color: Color(0xffEFEFEF),
                  thickness: 1,
                ),
                ListTile(
                    visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                    leading: Image.asset(
                      'assets/images/delete_user.png',
                      height: 18,
                    ),
                    title: Text('Delete Account',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: const Color(0xFF4F535E),
                          fontWeight: FontWeight.w400,
                        )),

                    onTap: () async {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Delete Account'),
                          content: const Text('Do You Want To Delete Your Account'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Get.back(),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {     deleteUserAccount().then((value){
                                if(value.status == true){
                                  showToast(value.message);
                                  Get.to(const LoginScreen());
                                }else{
                                  showToast(value.message);
                                }
                              });
                              } ,
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );



                    }
                ),
                const Divider(
                  height: 5,
                  color: Color(0xffEFEFEF),
                  thickness: 1,
                ),
                ListTile(
                  visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                  leading: Image.asset(
                    'assets/images/help_center.png',
                    height: 17,
                  ),
                  title: Text('Help Center',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: const Color(0xFF4F535E),
                        fontWeight: FontWeight.w400,
                      )),
                  onTap: () {
                    setState(() {
                      currentDrawer = 7;
                      Get.toNamed(MyRouters.help_Center_Screen);
                    });
                  },
                ),
                const Divider(
                  height: 5,
                  color: Color(0xffEFEFEF),
                  thickness: 1,
                ),
                ListTile(
                  visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                  leading: Image.asset(
                    'assets/images/logout.png',
                    height: 15,
                  ),
                  title: Text('Logout',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: const Color(0xFF4F535E),
                        fontWeight: FontWeight.w400,
                      )),
                  onTap: () async {
                    SharedPreferences pref = await SharedPreferences.getInstance();
                    pref.clear();
                    if (controller1.model.value.data != null) {
                      FirebaseService.removeFcmToken(controller1.model.value.data!.id.toString());
                    }
                    Get.offAllNamed(MyRouters.loginScreen);
                  },
                ),
              ],
            ),
          );
        }),
        appBar: AppBar(
          toolbarHeight: 60,
          elevation: 0,
          titleSpacing: 20,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            Obx(() {
              return Row(
                children: [
                  const Text(
                    ' Delivey Mode  ',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10, color: Color(0xFF303C5E)),
                  ),
                  FlutterSwitch(
                    height: AddSize.size20,
                    width: AddSize.size40,
                    activeColor: AppTheme.primaryColor,
                    toggleSize: AddSize.size5 * 2.5,
                    value: controller.model.value.data != null ? controller.model.value.data!.deliveryMode! : false,
                    // controller.isDataLoading.value
                    //     ? (controller.model.value.data!.deliveryMode ?? false)
                    //     : _store.value,
                    onToggle: (val) {
                      deliveryModeUpdateRepo().then((value) {
                        if (value.status == true) {
                          controller.getData();
                          controller.model.value.data!.deliveryMode = val;
                          if (controller.model.value.data!.deliveryMode == true) {
                            NewHelper.showToast("Delivery mode on");
                          } else {
                            NewHelper.showToast("Delivery mode off");
                          }
                        }
                      });
                    },
                  ),
                  SizedBox(
                    width: width * .020,
                  )
                ],
              );
            })
          ],
          leading: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  _scaffoldKey.currentState!.openDrawer();
                },

                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Image.asset(
                    'assets/images/BurgerIcon.png',
                    height: 35,
                  ),
                ),
                // child:
                //
                // Padding(
                //   padding: const EdgeInsets.only(left: 6),
                //    child : Obx(() {
                //       return ClipRRect(
                //         borderRadius: BorderRadius.circular(100),
                //         child: CachedNetworkImage(
                //           imageUrl: controller1.isDataLoading.value
                //               ? ( controller1
                //               .model.value.data!.profileImage).toString()
                //               : '',
                //           fit: BoxFit.cover,
                //           height: MediaQuery.of(context).size.height*.050,
                //           width: 40,
                //           errorWidget: (_, __, ___) => Image.asset(
                //             'assets/images/user_img.png',
                //             fit: BoxFit.contain,
                //             height: 30,
                //             width: 30,
                //           ),
                //           placeholder: (_, __) => const SizedBox(),
                //         ),
                //       );
                //     })
                // ),
              ),
            ],
          ),
          // leadingWidth: AddSize.size40 * ,
          title: InkWell(
            onTap: () {
              socket1!.emit(
                  'get_data', {"latitude": locationController.lat.value, "longitude": locationController.long.value});
            },
            child: const Text(
              'Dashboard',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17, color: Color(0xFF1A2E33)),
            ),
          ),
        ),
        body: RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          onRefresh: () async {
            await controller.getData();
            controller1.getData();
          },
          child: Obx(() {
            return controller.isDataLoading.value && controller1.isDataLoading.value
                ? SingleChildScrollView(

                    physics: const BouncingScrollPhysics(),

                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi'
                            ', ${controller.model.value.data!.username.toString().capitalizeFirst.toString()}',
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Color(0xFF303C5E)),
                          ),
                          addHeight(7.0),
                          const Text(
                            'Riders/Drivers that have delivery mode set to on for at least 4 hours a day and at least 5 days a week (and did not reject any order) will get 10% boost on next week earnings',
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Color(0xFF303C5E)),
                          ),
                          addHeight(25.0),
                          FittedBox(
                            child: Wrap(
                                children: List.generate(controller.model.value.data!.weekData!.length, (index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 28,
                                      width: 28,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4.0),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade300,
                                            offset: const Offset(
                                              .1,
                                              .1,
                                            ),
                                            blurRadius: 19.0,
                                            spreadRadius: 1.0,
                                          ),
                                        ],
                                      ),
                                      child: Theme(
                                        data: ThemeData(unselectedWidgetColor: Colors.transparent),
                                        child: Checkbox(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                                          value: controller.model.value.data != null
                                              ? controller.model.value.data!.weekData![index]
                                              : false,
                                          checkColor: Colors.white,
                                          activeColor: const Color(0xff7ED957),
                                          onChanged: (bool? value) {},
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            })),
                          ),
                          Wrap(
                              children: List.generate(days.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                              child: Column(
                                children: [
                                  Text(
                                    days[index].toString(),
                                    style: const TextStyle(
                                        fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF303C5E)),
                                  )
                                ],
                              ),
                            );
                          })),
                          addHeight(26.0),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 165,
                                  width: AddSize.screenWidth,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF5F5F5F).withOpacity(0.10),
                                          offset: const Offset(0.0, 0.5),
                                          blurRadius: 5,
                                        ),
                                      ]),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          right: 0,
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'assets/images/Group 362.png',
                                                height: 98,
                                              )
                                            ],
                                          )),
                                      Positioned(
                                          bottom: 10,
                                          left: 10,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.model.value.data!.deliveredOrders.toString(),
                                                style: const TextStyle(
                                                    color: Color(0xFF7ED957),
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 21),
                                              ),
                                              const Text(
                                                'Delivered',
                                                style: TextStyle(
                                                    color: Color(0xFF393E50),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14),
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              addWidth(19),
                              Expanded(
                                child: Container(
                                  height: 165,
                                  width: AddSize.screenWidth,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF5F5F5F).withOpacity(0.10),
                                          offset: const Offset(0.0, 0.5),
                                          blurRadius: 5,
                                        ),
                                      ]),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          right: 0,
                                          child: Image.asset(
                                            'assets/images/Group 363.png',
                                            height: 98,
                                          )),
                                      Positioned(
                                          bottom: 10,
                                          left: 10,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '€ ${controller1.model.value.data!.earnedBalance.toString()}',
                                                style: const TextStyle(
                                                    color: Color(0xFFFF980E),
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 21),
                                              ),
                                              const Text(
                                                'Earnings',
                                                style: TextStyle(
                                                    color: Color(0xFF393E50),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14),
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          addHeight(15.0),
                          Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF5F5F5F).withOpacity(0.10),
                                      offset: const Offset(0.0, 0.5),
                                      blurRadius: 5,
                                    ),
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Set Delivery Location Radius",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500, color: Color(0xff516670), fontSize: 14),
                                      ),
                                      Text(
                                        '${controller1.valueRange.round()} Km',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500, color: Color(0xff516670), fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: AddSize.screenWidth,
                                    child: Row(
                                      children: [
                                        SliderTheme(
                                          data: SliderTheme.of(context).copyWith(
                                            showValueIndicator: ShowValueIndicator.onlyForDiscrete,
                                            trackHeight: 8,
                                            trackShape: const RoundedRectSliderTrackShape(),
                                            activeTrackColor: const Color(0xff6CD241),
                                            inactiveTrackColor: const Color(0xFF7ED957).withOpacity(0.12),
                                            thumbShape: const RoundSliderThumbShape(
                                              enabledThumbRadius: 7.0,
                                              pressedElevation: 8.0,
                                            ),
                                            thumbColor: Colors.white,
                                            overlayColor: const Color(0xFF7ED957).withOpacity(0.12),
                                            overlayShape: const RoundSliderOverlayShape(overlayRadius: 2.0),
                                            tickMarkShape: const RoundSliderTickMarkShape(),
                                            activeTickMarkColor: const Color(0xff6CD241),
                                            inactiveTickMarkColor: Colors.transparent,
                                            valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                                            valueIndicatorColor: const Color(0xff6CD241),
                                            valueIndicatorTextStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          child: Expanded(
                                            child: Slider(
                                              min: 1.0,
                                              max: 15,
                                              autofocus: true,
                                              value: double.parse(controller1.valueRange.toString()) < 1.0
                                                  ? 1.0
                                                  : math.min(double.parse(controller1.valueRange.toString()), 15),
                                              divisions: 14,
                                              label: '${controller1.valueRange.round()} Km',
                                              onChangeEnd: (value) {
                                                setState(() {
                                                  controller1.valueRange = value;
                                                  value1 = value.toInt();
                                                });
                                                setDeliveryLocationRepo(
                                                  deliveryRange: value1,
                                                  context: context,
                                                ).then((value) async {
                                                  if (value.status == true) {
                                                    NewHelper.showToast(value.message);
                                                  }
                                                });
                                              },
                                              onChanged: (double value) {},
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                          addHeight(16.0),
                          Text(
                            'New Delivery Request',
                            style: GoogleFonts.raleway(
                                fontWeight: FontWeight.w600, fontSize: 16, color: const Color(0xFF303C5E)),
                          ),
                          addHeight(12.0),
                          Obx(() {
                            return controller.model.value.data!.list!.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller.model.value.data!.list!.length,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      var item = controller.model.value.data!.list![index];
                                      return Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: const Color(0xFF5F5F5F).withOpacity(0.10),
                                                  offset: const Offset(0.0, 0.5),
                                                  blurRadius: 5,
                                                ),
                                              ],
                                            ),
                                            child: Stack(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/calender_Img.png',
                                                        height: 18,
                                                      ),
                                                      addWidth(20),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              '#${item.orderId.toString()}',
                                                              style: const TextStyle(
                                                                  fontWeight: FontWeight.w800,
                                                                  fontSize: 14,
                                                                  color: Color(0xFF303C5E)),
                                                            ),
                                                            addHeight(4),
                                                            Text(
                                                              item.date.toString(),
                                                              style: GoogleFonts.raleway(
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: 15,
                                                                  color: const Color(0xFF303C5E)),
                                                            ),
                                                            addHeight(4),
                                                            Text(
                                                              "Pick up time: ${item.deliveryTime.toString()}",
                                                              style: GoogleFonts.raleway(
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: 15,
                                                                  color: const Color(0xFF303C5E)),
                                                            ),
                                                            addHeight(25),
                                                            Row(
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    assignedOrder(
                                                                            orderId: item.orderId.toString(),
                                                                            status: "accept",
                                                                            context: context)
                                                                        .then((value) {
                                                                      if (value.status == true) {
                                                                        controller.getData();
                                                                        assignedController.getOrderData1();
                                                                        Get.toNamed(MyRouters.assignedOrderScreen);
                                                                      }
                                                                    });
                                                                  },
                                                                  child: Container(
                                                                    padding: const EdgeInsets.symmetric(
                                                                        horizontal: 25, vertical: 6),
                                                                    decoration: BoxDecoration(
                                                                        color: const Color(0xFF7ED957),
                                                                        borderRadius: BorderRadius.circular(6)),
                                                                    child: Text(
                                                                      'Accept'.toUpperCase(),
                                                                      style: const TextStyle(
                                                                          fontWeight: FontWeight.w700,
                                                                          fontSize: 13,
                                                                          color: Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                                addWidth(16),
                                                                InkWell(
                                                                  onTap: () {
                                                                    assignedOrder(
                                                                            orderId: item.orderId,
                                                                            status: "decline",
                                                                            context: context)
                                                                        .then((value) {
                                                                      if (value.status == true) {
                                                                        assignedController.getOrderData1();
                                                                        Get.offAllNamed(MyRouters.orderDeclineScreen);
                                                                      }
                                                                    });
                                                                  },
                                                                  child: Container(
                                                                    padding: const EdgeInsets.symmetric(
                                                                        horizontal: 25, vertical: 6),
                                                                    decoration: BoxDecoration(
                                                                        color: const Color(0xFFF04148),
                                                                        borderRadius: BorderRadius.circular(6)),
                                                                    child: Text(
                                                                      'Decline'.toUpperCase(),
                                                                      style: const TextStyle(
                                                                          fontWeight: FontWeight.w700,
                                                                          fontSize: 13,
                                                                          color: Colors.white),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Positioned(
                                                    right: 5,
                                                    top: 8,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                                          decoration: BoxDecoration(
                                                              color: const Color(0xFF7ED957),
                                                              borderRadius: BorderRadius.circular(6)),
                                                          child: Text(
                                                            item.paymentMethod.toString(),
                                                            style: const TextStyle(
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 10,
                                                                color: Colors.white),
                                                          ),
                                                        ),
                                                        addWidth(8.0),
                                                        Text(
                                                          '€ ${item.orderTotal.toString()}',
                                                          style: const TextStyle(
                                                              fontWeight: FontWeight.w700,
                                                              fontSize: 14,
                                                              color: Color(0xFF7ED957)),
                                                        ),
                                                      ],
                                                    ))
                                              ],
                                            ),
                                          ),
                                          addHeight(15),
                                        ],
                                      );
                                    },
                                  )
                                : Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Center(
                                        child: Text(
                                          "No Delivery requests at the moment, try to expand the delivery area",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                              color: AppTheme.blackcolor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: AddSize.font14),
                                        ),
                                      ),
                                    ],
                                  );
                          }),
                          const SizedBox(height: 40,)
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                    color: Color(0xff7ED957),
                  ));
          }),
        ).manageNotification(
          context: context
        ),
      ),
    );
  }
}
