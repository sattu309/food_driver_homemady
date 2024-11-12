class WithdrawalRequestModel {
  bool? status;
  String? message;
  Data? data;

  WithdrawalRequestModel({this.status, this.message, this.data});

  WithdrawalRequestModel.fromJson(Map<String, dynamic> json) {
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
  dynamic userId;
  String? amount;
  String? status;
  String? updatedAt;
  String? createdAt;
  dynamic id;

  Data(
      {this.userId,
        this.amount,
        this.status,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    amount = json['amount'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['amount'] = amount;
    data['status'] = status;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}