class MessageModel {
  String? textMessage;
  String? senderId;
  DateTime? messageSentTime;
  String? messageType;
  String highlightDate = "";

  MessageModel({
    this.textMessage,
    this.senderId,
    this.messageSentTime,
    this.messageType,
  });

  MessageModel.fromMap(Map<dynamic, dynamic> map) {
    textMessage = map["text_message"] ?? "";
    senderId = map["sender_id"].toString();
    messageSentTime = DateTime.fromMillisecondsSinceEpoch(map["message_sent_time"]);
    messageType = map["message_type"].toString();
  }

  Map<String, dynamic> toMap() {
    return {
      "text": textMessage,
      "message_sent_time": messageSentTime,
      "message_type": messageType,
      "sender_id": senderId,
    };
  }
}


class ChatDataModel {
  UsersInfo? usersInfo;
  List<String>? creators;
  DateTime? lastMessageTime;
  String? lastMessage;
  String? roomId;
  String? orderID;
  String? lastMessageSender;

  ChatDataModel(
      {this.usersInfo,
        this.creators,
        this.lastMessageTime,
        this.orderID,
        this.roomId,
        this.lastMessage,
        this.lastMessageSender});

  ChatDataModel.fromJson(Map<String, dynamic> json) {
    usersInfo = json['usersInfo'] != null
        ? UsersInfo.fromJson(json['usersInfo'])
        : null;
    creators = json['creators'].cast<String>();
    lastMessageTime = DateTime.fromMillisecondsSinceEpoch(json['last_message_time']);
    roomId = json['roomId'];
    lastMessage = json['last_message'];
    orderID = json['orderID'];
    lastMessageSender = json['last_message_sender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (usersInfo != null) {
      data['usersInfo'] = usersInfo!.toJson();
    }
    data['creators'] = creators;
    data['last_message_time'] = lastMessageTime;
    data['last_message'] = lastMessage;
    data['last_message_sender'] = lastMessageSender;
    return data;
  }
}

class UsersInfo {
  Driver? driver;
  Driver? customer;
  Driver? vendor;

  UsersInfo({this.driver, this.customer, this.vendor});

  UsersInfo.fromJson(Map<String, dynamic> json) {
    driver = json['driver'] != null ? Driver.fromJson(json['driver']) : null;
    vendor = json['vendor'] != null ? Driver.fromJson(json['vendor']) : null;
    customer =
    json['customer'] != null ? Driver.fromJson(json['customer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (driver != null) {
      data['driver'] = driver!.toJson();
    }
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (vendor != null) {
      data['vendor'] = vendor!.toJson();
    }
    return data;
  }
}

class Driver {
  String? userId;
  String? userImage;
  String? userName;

  Driver({this.userId, this.userImage, this.userName});

  Driver.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userImage = json['user_image'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_image'] = userImage;
    data['user_name'] = userName;
    return data;
  }
}