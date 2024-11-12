import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:homemady_drivers/widgets/helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/verify_otp_model.dart';
import '../../api_url/api_url.dart';
import '../../controller/userProfile_controller.dart';
import '../../firebase_service/firebase_service.dart';
import '../../models/chat_model/chat_image_model.dart';
import '../../models/chat_model/chat_model.dart';
import '../../widgets/custome_textfiled.dart';
import '../../widgets/dimenestion.dart';
import 'chat_bubble.dart';
import 'package:http/http.dart' as http;

class MainChatScreen extends StatefulWidget {
  const MainChatScreen({
    Key? key,
    required this.roomId,
    required this.orderId,
    required this.senderId,
    required this.receiverId,
    required this.receiverName,
    required this.receiverImage,
    this.customer,
    this.vendor,
    this.driver,
    // this.initialMessage,
  }) : super(key: key);
  final String roomId;
  final String orderId;
  final String senderId;
  final String receiverId;
  final String receiverName;
  final String receiverImage;
  final Map? customer;
  final Map? vendor;
  final Map? driver;
  // final String? initialMessage;

  @override
  State<MainChatScreen> createState() => _MainChatScreenState();
}

class _MainChatScreenState extends State<MainChatScreen> {
  FirebaseService service = FirebaseService();
  final TextEditingController messageController = TextEditingController();

  File pickedImage = File("");
  RxString profileImage = "".obs;
  File image2 = File("");
  File? selectedImage;
  String? base64Image;

  List imageTypes = [
    "jpeg",
    "jpg",
    "png",
    "gif",
    "bmp",
    "webp",
    "svg+xml",
    "tiff",
    "x-icon",
    "vnd.microsoft.icon",
    "vnd.adobe.photoshop",
    "xcf",
  ];

  final profileController = Get.put(UserProfileController());

  RxInt lastTimeByOther = 0.obs;
  DateTime? lastTimeByOtherTime;

  Future<void> chooseImage(type) async {
    var image;
    if (type == "camera") {
      image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        // source: ImageSource.camera,
        imageQuality: 15,
      );
    } else {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        image = File(result.files.single.path.toString());

        if (imageTypes.contains(result.files.single.path.toString().split(".").last)) {
          image2 = (await FileCompressionApi.compressImage(image))!;
          image = image2;
        }
      }
    }
    if (image != null) {
      setState(() {
        selectedImage = File(image!.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
        // OverlayEntry loader = Helpers.overlayLoader(context);
        // Overlay.of(context).insert(loader);
        sendImage(
          fieldName1: "image",
          file1: selectedImage!,
        ).then((value) {
          log("00000000000000$selectedImage");
          if (value.status == true) {
            log("55555555555${value.data!.image.toString()}");
            service.sendMessage(
                roomId: widget.roomId,
                fcmTokens: fcmTokens,
                orderID: widget.orderId,
                message: value.data!.image.toString(),
                senderId: widget.senderId,
                messageType: MessageType.withImage,
                usersInfo: {
                  if (widget.customer != null) "customer": widget.customer,
                  if (widget.vendor != null) "vendor": widget.vendor,
                  if (widget.driver != null) "driver": widget.driver,
                },
                receiverId: widget.receiverId);
            // service
            //     .sendMessage(
            //     roomId: chatRoomId,
            //     message: value.data!.image.toString(),
            //     senderId: senderID,
            //     messageType: MessageType.withImage,
            //     orderDetail: orderDetails,
            //     allowSet: !fromApi)
            //     .then((value) {
            //   messageController.clear();
            // });
          } else {
            log("55555555555${value.data!.image.toString()}");

            showToast(value.status);
          }
        });
      });
    }
  }

  List<String> fcmTokens = [];

  @override
  void initState() {
    super.initState();
    FirebaseService().availableFCMTokens(widget.receiverId.toString()).then((value) {
      fcmTokens = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(useMaterial3: true, dividerColor: Colors.transparent,),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.white,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          bottom: PreferredSize(
            preferredSize: Size(AddSize.screenWidth, AddSize.size14),
            child: Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(offset: const Offset(0, 3), color: Colors.grey.withOpacity(.090), blurRadius: 1),
                const BoxShadow(offset: Offset(0, -1), color: Colors.white, blurRadius: 20),
              ]),
              height: AddSize.size10,
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(16),
            child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(Icons.arrow_back)),
          ),
          title: Row(
            children: [
              Image.network(
                widget.receiverImage.toString(),
                height: 30,
                width: 30,
                errorBuilder: (_, __, ___) => const Icon(Icons.person),
              ),
              InkWell(
                onTap: () {
                  // Get.toNamed(ChatInformationScreen.chatInformation);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.receiverName,
                        style: TextStyle(fontSize: AddSize.font14, fontWeight: FontWeight.w500, color: const Color(0xFF1F2124))),
                    // Text(DateFormat("hh:mm a").format(DateTime.fromMillisecondsSinceEpoch(lastTimeByOther.value)),
                    //     style: TextStyle(fontSize: AddSize.font10, fontWeight: FontWeight.w300, color: const Color(0xFF1F2124))),
                    // Text('last seen recently',style: TextStyle(fontSize: AddSize.font8,fontWeight: FontWeight.w400,color: Color(0xFF303D48))),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: service.getMessagesList(roomId: widget.roomId),
                  builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.hasData) {
                      List<MessageModel> messagesList = [];
                      messagesList = snapshot.data!.docs.map((e) => MessageModel.fromMap(e.data())).toList();
                      String givenValue = "";
                      messagesList.reversed.toList().forEach((element) {
                        // print(element.messageSentTime!.isCurrentData);
                        if (element.messageSentTime == null) return;
                        if (element.messageSentTime!.toSimpleDate.toString() != givenValue) {
                          element.highlightDate = element.messageSentTime!.toSimpleDate.toString();
                          givenValue = element.messageSentTime!.toSimpleDate.toString();
                          // print(givenValue);
                        }
                      });

                      // print(messagesList[0].textMessage);
                      return ListView.builder(
                        // physics: BouncingScrollPhysics(),
                        reverse: true,
                        shrinkWrap: true,
                        itemCount: messagesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Obx(() {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: ChatBubble(
                                isMe: widget.senderId == messagesList[index].senderId.toString(),
                                highlightTime: DateTime.tryParse(messagesList[index].highlightDate),
                                message: messagesList[index].textMessage.toString(),
                                sentTime: messagesList[index].messageSentTime,
                                messageSeen: messagesList[index].messageSentTime != null && lastTimeByOther.value != 0
                                    ? lastTimeByOther.value > messagesList[index].messageSentTime!.microsecondsSinceEpoch
                                    : false,
                                messageType: messagesList[index].messageType.toString(),
                              ),
                            );
                          });
                        },
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
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
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      // pickImage(ImageSource.gallery);
                      chooseImage('Gallery');
                    },
                    child: Image.asset(
                      'assets/images/add-square.png',
                      height: 28,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // imagePickerOption();
                      chooseImage('camera');
                    },
                    child: Image.asset(
                      'assets/images/camera1.png',
                      height: 28,
                    ),
                  ),
                  SizedBox(
                    width: 260,
                    child: CommonTextFieldWidgetSearch1(
                      controller: messageController,
                      hint: 'Type messages...',
                      suffix: IconButton(
                          onPressed: () {
                            if (messageController.text.trim().isEmpty) return;
                            String kk = messageController.text.trim();
                            messageController.clear();
                            service.sendMessage(
                                orderID: widget.orderId,
                                roomId: widget.roomId,
                                fcmTokens: fcmTokens,
                                message: kk,
                                receiverId: widget.receiverId,
                                senderId: widget.senderId,
                                messageType: MessageType.simpleMessage,
                                usersInfo: {
                                  if (widget.customer != null) "customer": widget.customer,
                                  if (widget.vendor != null) "vendor": widget.vendor,
                                  if (widget.driver != null) "driver": widget.driver,
                                });
                          },
                          icon: Image.asset(
                            'assets/images/PaperPlaneRight.png',
                            height: 25,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FileCompressionApi {
  //Compressing the picked image
  static Future<File?> compressImage(File file) async {
    try {
      final compressedFile = await FlutterNativeImage.compressImage(file.path, quality: 50, percentage: 10);
      return compressedFile;
    } catch (e) {
      return null; //If any error occurs during compression, the process is stopped.
    }
  }
}

Future<ChatImageModal> sendImage({required fieldName1, required File file1}) async {
  try {
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrl.sendImageUrl));
    SharedPreferences pref = await SharedPreferences.getInstance();
    ModelVerifyOtp? user = ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
    };
    request.headers.addAll(headers);

    //request.fields.addAll(mapData);

    if (file1.path != "") {
      log(file1.path);
      log("99999999999999999999");
      request.files.add(await multipartFile(fieldName1, file1));
    }

    log(request.fields.toString());
    log(request.files.map((e) => e.filename).toList().toString());
    final response = await request.send();
    String apiResponse = await response.stream.bytesToString();
    log("apiResponse........    $apiResponse");
    log("apiResponse........    ${request.fields.toString()}");

    if (response.statusCode == 200 || response.statusCode == 400) {
      return ChatImageModal.fromJson(jsonDecode(apiResponse));
    } else {
      return ChatImageModal.fromJson(jsonDecode(apiResponse));
    }
  } on SocketException {
    return ChatImageModal(status: true);
  } catch (e) {
    return ChatImageModal(status: true);
  }
}

Future<http.MultipartFile> multipartFile(String? fieldName, File file1) async {
  return http.MultipartFile(
    fieldName ?? "file_data",
    http.ByteStream(Stream.castFrom(file1.openRead())),
    await file1.length(),
    filename: file1.path.split('/').last,
  );
}

showToast(message) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
