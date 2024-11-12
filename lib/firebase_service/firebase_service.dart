import 'dart:developer';
import 'package:client_information/client_information.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import '../models/order_details_cooks_copy_model.dart';
import '../services/push_notification.dart';
enum MessageType{
  simpleMessage,
  withImage,
}

class FirebaseService{
  static String messageCollection = "chats_list";

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessagesList({
    required String roomId,
  }){
    return fireStore.collection(messageCollection).doc(roomId).collection("messages").orderBy("message_sent_time", descending: true).snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getRoomInfoStream({
    required String roomId,
  }){
    return fireStore.collection(messageCollection).doc(roomId).snapshots();
  }

  Future<List<String>> availableFCMTokens(String userId) async {
    final item = await FirebaseFirestore.instance.collection("users_info").doc(userId).get();
    if(!item.exists)return [];
    if(item.data() == null)return [];
    return item.data()!.entries.map((e) => e.value.toString()).toList();
  }

  static updateUserFcmToken(String userId) async {
    final item = await FirebaseFirestore.instance.collection("users_info").doc(userId).get();
    String? fcm = await FirebaseMessaging.instance.getToken();
    ClientInformation info = await ClientInformation.fetch();
    log("Device Info....     ${info.toJson()}");
    if (fcm == null) return;
    if (item.exists) {
      await item.reference.update({info.deviceId: fcm});
    } else {
      await item.reference.set({info.deviceId: fcm});
    }
  }

  static removeFcmToken(String userId) async {
    final item = await FirebaseFirestore.instance.collection("users_info").doc(userId).get();
    String? fcm = await FirebaseMessaging.instance.getToken();
    ClientInformation info = await ClientInformation.fetch();
    if (fcm == null) return;
    if (item.exists) {
      await item.reference.update({info.deviceId: null});
    }
  }

  Future<int> getUnseenCount({
    required String roomId,
    required DateTime lastSeen
  }) async {
    int length = 0;
    // print(lastSeen);
    await fireStore.collection(messageCollection).doc(roomId)
        .collection("messages")
        .where("last_message_time",isLessThan: lastSeen)
        .limit(12).get().then((value) {
      // print(value.docs.length);
      length = value.docs.length;
      // return value;
    });
    return length;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getRoomsListStream({
    required String profileID,
  }){
    return fireStore.collection(messageCollection).where("creators", arrayContains: profileID)
        .orderBy("last_message_time", descending: true).snapshots();
  }

  Future<OrderDetail?> getRoomInfo({
    required String roomId,
  }) async {
    var gg = await fireStore.collection(messageCollection).doc(roomId).get();
    if(gg.exists) {
      if(gg.data() == null){
        return null;
      }
      var mm = gg.data()!["data"];
      return OrderDetail.fromJson(mm as Map);
    }
    return null;
  }

  Future<int> getUnreadMessages({required String roomId,required DateTime lastTime}) async {
    QuerySnapshot<Map<String, dynamic>> docSnap =
    await fireStore.collection(messageCollection).doc(roomId).collection("messages").where("time",isGreaterThan: lastTime).get();
      // print(docSnap.docs.map((e) => e.data().toString()).toList());
    return docSnap.docs.length;
  }

  updateLastSeen({
    required String roomId,
    required String myId,
  }) async {
    await fireStore.collection(messageCollection).doc(roomId).update({
      "last_time_$myId" : DateTime.now().microsecondsSinceEpoch
    }).then((value) {
      log("last time updated....      $myId");
    });
  }

  Future sendMessage({
    required String roomId,
    required String orderID,
    required String message,
    required String senderId,
    required String receiverId,
    required List<String> fcmTokens,
    required MessageType messageType,
    Map<String, dynamic>? usersInfo,
  }) async {
    DateTime currentTime = DateTime.now();

    Map<String, dynamic> map = {};
    map["text_message"] = message;
    map["sender_id"] = senderId;
    map["message_type"] = messageType.name;
    map["message_sent_time"] = currentTime.millisecondsSinceEpoch;

    await fireStore.collection(messageCollection).doc(roomId)
        .collection("messages").add(map).then((value) async {

      sendNotification(
          token: fcmTokens,
          msgBody: messageType == MessageType.simpleMessage ? message : "Sent Image",
          msgTitle: "New Message from order $orderID"
      );
      final item = await fireStore.collection(messageCollection).doc(roomId).get();
      if(item.exists){
        Map<String, dynamic> map1 = {};
        map1["last_message"] = message;
        map1["last_message_time"] = currentTime.millisecondsSinceEpoch;
        map1["last_message_sender"] = senderId;
        map1["creators"] = [senderId, receiverId];
        await fireStore.collection(messageCollection).doc(roomId).update(map1).then((value) {
          log("Message Updated...     $map1");
        });
      }
      else {
        Map<String, dynamic> map1 = {};
        map1["last_message"] = message;
        map1["roomId"] = roomId;
        map1["orderID"] = orderID;
        map1["last_message_time"] = currentTime.millisecondsSinceEpoch;
        map1["last_message_sender"] = senderId;
        map1["usersInfo"] = usersInfo;
        map1["creators"] = [senderId, receiverId];
        await fireStore.collection(messageCollection).doc(roomId).set(map1).then((value) {
          log("Message Updated...     $map1");
        });
      }

    });
  }


  String createChatRoom({
    required int user1,
    required int user2,
  }){
    String gg = "";
    if(user1 > user2){
      gg = "$user1 -- $user2";
    } else {
      gg = "$user2 -- $user1";
    }
    return gg;
  }
}

extension ConverToNum on String{
  num get convertToNum{
    return num.tryParse(this) ?? 0;
  }
}