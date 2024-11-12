import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../controller/driver_information_controller.dart';
import '../../controller/userProfile_controller.dart';
import '../../firebase_service/firebase_service.dart';
import '../../models/chat_model/chat_model.dart';
import '../../widgets/dimenestion.dart';
import 'main_chat_screen.dart';

class ChattingListScreen extends StatefulWidget {
  const ChattingListScreen({Key? key, required this.myUserId}) : super(key: key);
  final String myUserId;
  @override
  ChattingListScreenState createState() => ChattingListScreenState();
}

class ChattingListScreenState extends State<ChattingListScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Theme(
        data: ThemeData(useMaterial3: true, dividerColor: Colors.transparent,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(offset: const Offset(0, 3), color: Colors.grey.withOpacity(.090), blurRadius: 1),
                const BoxShadow(offset: Offset(0, -1), color: Colors.white, blurRadius: 20),
              ]),
              child: Padding(
                padding: EdgeInsets.only(top: height * .045),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15).copyWith(left: 2),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: Colors.white),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 25,
                              ))),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Chat'.tr,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff303C5E),
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseService().getRoomsListStream(profileID: widget.myUserId),
                  builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.hasData) {
                      List<ChatDataModel> gg = snapshot.data!.docs.map((e) => ChatDataModel.fromJson(e.data())).toList();
                      return gg.isNotEmpty
                          ? ListView.builder(
                              itemCount: gg.length,
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(top: 10),
                              itemBuilder: (BuildContext context, int index) {
                                final chatData = gg[index];
                                final userInfo = chatData.usersInfo!.vendor ?? chatData.usersInfo!.customer;
                                return InkWell(
                                  onTap: () async {
                                    String? myUserId = await getMyUserId();
                                    log(chatData.roomId.toString());
                                    Get.to(() => MainChatScreen(
                                          roomId: chatData.roomId.toString(),
                                          orderId: chatData.orderID.toString(),
                                          receiverId: userInfo.userId.toString(),
                                          receiverName: userInfo.userName.toString(),
                                          receiverImage: userInfo.userImage.toString(),
                                          senderId: myUserId!,
                                        ));
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.white, border: Border(bottom: BorderSide(color: Color(0xFFE5E5E5)))
                                        ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Stack(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(40),
                                                          child: Image.network(
                                                            userInfo!.userImage.toString(),
                                                            height: 50,
                                                            width: 50,
                                                            fit: BoxFit.contain,
                                                            errorBuilder: (_, __, ___) => Container(
                                                                height: 50,
                                                                width: 50,
                                                                decoration: const BoxDecoration(color: Colors.grey),
                                                                child: const Icon(
                                                                  Icons.person,
                                                                  color: Colors.white,
                                                                )),
                                                            loadingBuilder: (_, __, ___) {
                                                              if (___ == null) {
                                                                return __;
                                                              }
                                                              return const Center(
                                                                child: CircularProgressIndicator.adaptive(),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: AddSize.size12,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      userInfo.userName.toString().capitalize!,

                                                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15),
                                                    ),
                                                    SizedBox(
                                                      height: height * .005,
                                                    ),
                                                    Text(
                                                      chatData.lastMessage.toString(),
                                                      style: GoogleFonts.poppins(
                                                          fontWeight: FontWeight.w400, fontSize: 12, color: Colors.grey.shade700),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                DateFormat("HH:mm a \n dd/MMM").format(chatData.lastMessageTime!),
                                                textAlign: TextAlign.right,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: Color(0xFFAAAFB5),
                                                    fontFamily: 'Poppins'),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })
                          : Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/message_image.png',
                                      height: 250,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "No Messages",
                                      style: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      child: Text(
                                        "Bong, it seems that you do not have any messages at the moment",
                                        style: TextStyle(color: Color(0xff9E9E9E), fontSize: 18, fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                    }
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}


Future<String?> getMyUserId() async {

  final driverController = Get.put(UserProfileController(),permanent: true);

  if(driverController.model.value.data != null){
    driverController.getData();
    return driverController.model.value.data!.id.toString();
  }
 final item = await driverController.getData();
  if(item.data == null){
    return null;
  }
  return item.data!.id.toString();
}
