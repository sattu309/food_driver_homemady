class NotificationModel {
  bool? status;
  String? message;
  Data? data;

  NotificationModel({this.status, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic count;
  List<NotificationData>? notificationData;

  Data({this.count, this.notificationData});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['notificationData'] != null) {
      notificationData = <NotificationData>[];
      json['notificationData'].forEach((v) {
        notificationData!.add(NotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (notificationData != null) {
      data['notificationData'] =
          notificationData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  dynamic id;
  dynamic orderId;
  String? title;
  String? body;
  String? notificationType;
  dynamic seen;
  String? time;

  NotificationData(
      {this.id,
        this.title,
        this.orderId,
        this.body,
        this.notificationType,
        this.seen,
        this.time});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    orderId = json['order_id'];
    body = json['body'];
    notificationType = json['notification_type'];
    seen = json['seen'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['order_id'] = orderId;
    data['body'] = body;
    data['notification_type'] = notificationType;
    data['seen'] = seen;
    data['time'] = time;
    return data;
  }
}
